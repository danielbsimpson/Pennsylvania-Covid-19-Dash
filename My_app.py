import dash
import dash_table
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import pandas as pd
import dash_bootstrap_components as dbc
import json
import plotly.graph_objs as go
import numpy as np
from dash.dependencies import Input, Output

with open('geojson-counties-fips.json') as f:
    counties = json.load(f)

df = pd.read_csv('PA_data.csv')
df['R_minus'] = df['R_mean'] - df['R_low']
df['R_plus'] = df['Rhigh'] - df['R_mean']
df['dailycases_p100k_7d_avg'] = df['dailycases_p100k_7d_avg'].round(5)
df['inf_potential_p100k'] = df['inf_potential_p100k'].round(5)

df.rename(columns={'county_name': 'County',
                   'population': 'Population',
                   'dailycases_p100k_7d_avg': 'Daily Cases',
                   'R_mean': 'R mean',
                   'R_low': 'R Low',
                   'Rhigh': 'R High',
                   'inf_potential_p100k': 'Infection Potential'},
          inplace=True)

df_time = pd.read_csv('PA_time_series_data.csv')
df_time['Date'] = pd.to_datetime(df_time['Date'])

fig2 = px.choropleth(df, geojson=counties, locations='fips', color='Infection Potential',
                     scope="usa",
                     labels={
                         'Infection Potential': 'Infection Potential <br>per 100k'},
                     color_continuous_scale="reds",
                     hover_name=df['County'],
                     range_color=[0, df['Infection Potential'].max()]
                     )
layout = go.Layout(geo=dict(bgcolor='rgba(0,0,0,0)'),
                   title=go.layout.Title(
                       text="Pennsylvania Infection Potential by County",
                       x=0.5
),
    font=dict(size=16)
)

fig2.update_layout(layout)
fig2.update_geos(fitbounds="locations",
                 visible=True,
                 )

external_stylesheets = [dbc.themes.LUX]

app = dash.Dash(
    __name__, external_stylesheets=external_stylesheets, title='PA Counties')

server = app.server

app.config.suppress_callback_exceptions = True

app.layout = html.Div([
    dbc.Container([
        dbc.Row([
            dbc.Col(html.H1('COVID-19 in Pennsylvania'), className="mb-2")
        ]),
        dbc.Row([
            dbc.Col(html.H6(
                children='Visualising and tracking Covid-19 in Pennsylvania Counties'), className="mb-4")
        ]),

        dbc.Row([
            dbc.Col(dbc.Card(html.H3(children='Data from 27-Oct-2020',
                                     className="text-center text-light bg-dark"),
                             body=True, color="dark"),
                    className="mb-4"
                    )
        ]),
        dash_table.DataTable(
            id='datatable-PA',
            columns=[{"name": i, "id": i} for i in ['County',
                                                    'Population',
                                                    'Daily Cases',
                                                    'R Low',
                                                    'R mean',
                                                    'R High',
                                                    'Infection Potential']],
            data=df.to_dict('records'),
            editable=False,
            sort_action='native',
            sort_mode='single',
            column_selectable='single',
            filter_action='native',
            page_action='native',
            page_current=0,
            page_size=5,
            style_cell={
                'minWidth': 95, 'maxWidth': 105, 'width': 95
            },
            style_cell_conditional=[
                {
                    'if': {'column_id': 'County'},
                    'textAlign': 'left',
                }
            ],
            style_data={
                'whiteSpace': 'normal',
                'height': 'auto',
            },
            style_header={
                'backgroundColor': 'rgb(230, 230, 230)',
                'fontWeight': 'bold'
            },
        ),
        dcc.Graph(
            id='r_scatter',
            figure={}
        ),
        dcc.Graph(
            id='choropleth',
            figure=fig2
        ),
        dcc.Dropdown(id='drop_bar',
                     options=[{'label': x, 'value': x}
                              for x in df.County.unique()],
                     value='Adams',
                     multi=False,
                     ),
        dcc.Graph(
            id='time_graph',
            figure={}
        ),
        dcc.Graph(
            id='R_rate',
            figure={}
        ),
    ])
])


@app.callback(
    Output(component_id='r_scatter', component_property='figure'),
    [Input(component_id='datatable-PA', component_property="derived_virtual_data")]
)
def update_scatter(all_rows_data):
    dff = pd.DataFrame(all_rows_data)
    fig0 = go.Figure(data=go.Scatter(x=dff['R mean'],
                                y=dff['Daily Cases'],
                                error_x=dict(type='data',
                                             symmetric=False,
                                             array=dff['R_plus'],
                                             arrayminus=dff['R_minus'],
                                             thickness=0.5,
                                             ),
                                mode='markers',
                                marker=dict(size=np.log2(dff['Population']),
                                            color=dff['Infection Potential'],
                                            colorbar=dict(
                                                title="Infection <br>Potential"
                                            ),
                                            colorscale="matter"
                                            ),
                                hovertemplate=dff['County'] +
                                '<br>R Rate (mean): %{x:.2f}' +
                                '<br>Daily Cases: %{y}<br><extra></extra>',
                                )
                )
    fig0.update_layout(
        autosize=False,
        width=900,
        height=900,
        hoverlabel=dict(
            bgcolor="white",
            font_size=16,
            font_family="Rockwell",
        ),
        font_family="Ariel",
        font_color='Black',
        title={
            'text': 'Pennsylvania Counties',
            'font_size': 20,
            'y': 0.95,
            'x': 0.5,
            'xanchor': 'center',
            'yanchor': 'top'},
        xaxis_title={
            'text': "R rate",
            'font_size': 16
        },
        yaxis_title={
            'text': "Daily Cases per 100k (7 Day Average)",
            'font_size': 16
        },
        shapes=[dict(
            type='line',
            x0=1,
            x1=1,
            y0=0,
            y1=68,
            line=dict(
                color='Black',
                dash='dash'))
                ],
        showlegend=False,
    )
    fig0.update_xaxes(
        range=[0.2, 6]
    )
    fig0.update_yaxes(
        range=(0, 68)
    )
    return fig0


@app.callback(
    [Output(component_id='time_graph', component_property='figure'),
     Output(component_id='R_rate', component_property='figure')],
    [Input(component_id='drop_bar', component_property='value')]
)
def update_graph(option_county):
    dff = df_time.copy()
    dff = dff[dff['Admin2'] == option_county]
    dff = dff[dff['Confirmed'] >= 1]
    fig1 = go.Figure(data=[
        go.Bar(name='Cases',
               x=dff['Date'],
               y=dff['Daily Confirmed'],
               marker_color='blue',
               hovertemplate='Cases: %{y}<br><extra></extra>'),
        go.Bar(name='Deaths',
               x=dff['Date'],
               y=dff['Daily Deaths'],
               marker_color='red',
               hovertemplate='Deaths: %{y}<br><extra></extra>')
    ])
    fig1.update_layout(title_text='{0} County<br>Total Cases: {1}, Total Deaths: {2}'.format(str(option_county), str(
        dff['Confirmed'].iloc[-1]), str(dff['Deaths'].iloc[-1])),
        barmode='stack')

    fig1.add_trace(go.Scatter(x=dff['Date'],
                              y=dff['7_day_avg'],
                              mode='lines',
                              name='7 Day Average',
                              line=dict(color='rgb(184,55,223)'),
                              hovertemplate='7 Day Average: %{y}<br><extra></extra>'
                              )
                   )
    fig1.update_layout(
        title={
            'y': .91,
            'x': 0.5,
            'xanchor': 'center',
            'yanchor': 'top'},
        xaxis_title="Date",
        yaxis_title="Daily Count",
        hovermode="x",
    )

    r_df = pd.read_csv('R files/' + str(option_county) + '_r.csv')
    r_df['Date'] = pd.to_datetime(r_df['Date'])
    type(r_df['Mean'] - r_df['0.05'])
    type(r_df['Mean'])
    fig3 = go.Figure([
        go.Scatter(
            name='R mean',
            x=r_df['Date'],
            y=r_df['Mean'],
            mode='lines',
            line=dict(color='rgb(31, 119, 180)'),
        ),
        go.Scatter(
            name='Upper Bound',
            x=r_df['Date'],
            y=r_df['Mean']+(r_df['0.95'] - r_df['Mean']),
            mode='lines',
            marker=dict(color="#444"),
            line=dict(width=0),
            showlegend=False
        ),
        go.Scatter(
            name='Lower Bound',
            x=r_df['Date'],
            y=r_df['Mean']-(r_df['Mean'] - r_df['0.05']),
            marker=dict(color="#444"),
            line=dict(width=0),
            mode='lines',
            fillcolor='rgba(68, 68, 68, 0.3)',
            fill='tonexty',
            showlegend=False
        )
    ])
    fig3.update_layout(
        yaxis_title='R rate',
        title='Reproduction rate of Covid-19 in '
        + str(option_county)
        + ' county with 95% CI<br>Mean SI = 3.96<br>Standard deviation SI = 4.75',
        hovermode="x"
    )

    return fig1, fig3


if __name__ == '__main__':
    app.run_server(debug=True)