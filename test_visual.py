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
import math

df= pd.read_csv('4_weeks_PA_data.csv')
df['R_minus'] = df['R_mean'] - df['R_low']
df['R_plus'] = df['R_high'] - df['R_mean']
df['dailycases_p100k_7d_avg'] = df['dailycases_p100k_7d_avg'].round(5)

date_list = list(df.Date.unique())
counties = list(df.county_name.unique())

df.rename(columns={'county_name': 'County',
                   'population': 'Population',
                   'dailycases_p100k_7d_avg': 'Daily Cases',
                   'R_mean': 'R mean',
                   'R_low': 'R Low',
                   'R_high': 'R High'},
        inplace=True)

low_x = df['R mean'].min()
high_x = df['R mean'].max()
low_y = df['Daily Cases'].min()
high_y = df['Daily Cases'].max()

fig_dict = {
    "data": [],
    "layout": {},
    "frames": []
}

# fill in most of layout
fig_dict["layout"]["xaxis"] = {"range": [low_x, high_x], "title": "Reproduction Rate"}
fig_dict["layout"]["yaxis"] = {"range": [low_y-10, high_y], "title": "Infection Rate (7 day average)"}
fig_dict["layout"]["width"] = 900
fig_dict["layout"]["height"] = 1100
fig_dict["layout"]["hoverlabel"] =dict(bgcolor="white",
                                        font_size=16,
                                        font_family="Rockwell",
                                        )

fig_dict["layout"]["hovermode"] = "closest"
fig_dict["layout"]["shapes"] = [dict(
            type='line',
            x0=1,
            x1=1,
            y0=low_y-10,
            y1=high_y,
            line=dict(
                color='Black',
                dash='dash'))
                ]
fig_dict["layout"]["title"] = {
            'text': 'Pennsylvania Counties',
            'font_size': 20,
            'y': 0.95,
            'x': 0.5,
            'xanchor': 'center',
            'yanchor': 'top'}
            
fig_dict["layout"]["updatemenus"] = [
    {
        "buttons": [
            {
                "args": [None, {"frame": {"duration": 500, "redraw": False},
                                "fromcurrent": True, "transition": {"duration": 300,
                                                                    "easing": "quadratic-in-out"}}],
                "label": "Play",
                "method": "animate"
            },
            {
                "args": [[None], {"frame": {"duration": 0, "redraw": False},
                                  "mode": "immediate",
                                  "transition": {"duration": 0}}],
                "label": "Pause",
                "method": "animate"
            }
        ],
        "direction": "left",
        "pad": {"r": 10, "t": 87},
        "showactive": False,
        "type": "buttons",
        "x": 0.1,
        "xanchor": "right",
        "y": 0,
        "yanchor": "top"
    }
]

sliders_dict = {
    "active": 0,
    "yanchor": "top",
    "xanchor": "left",
    "currentvalue": {
        "font": {"size": 20},
        "prefix": "Date:",
        "visible": True,
        "xanchor": "right"
    },
    "transition": {"duration": 300, "easing": "cubic-in-out"},
    "pad": {"b": 10, "t": 50},
    "len": 0.9,
    "x": 0.1,
    "y": 0,
    "steps": []
}

# make data
date = list(df.Date.unique())[0]
for county in counties:
    dataset_by_date = df[df["Date"] == date]
    dataset_by_date_and_cont = dataset_by_date[
        dataset_by_date["County"] == county]

    data_dict = {
        "x": list(dataset_by_date_and_cont["R mean"]),
        "error_x": dict(type='data',
                                symmetric=False,
                                array=dataset_by_date_and_cont['R_plus'],
                                arrayminus=dataset_by_date_and_cont['R_minus'],
                                thickness=0.5,
                            ),
        "y": list(dataset_by_date_and_cont["Daily Cases"]),
        "mode": "markers",
        "marker" : dict(size=np.log2(dataset_by_date_and_cont['Population'])),
        "hovertemplate":dataset_by_date_and_cont['County'] +
                                '<br>R Rate (mean): %{x:.2f}' +
                                '<br>Daily Cases: %{y}<br><extra></extra>',
        "text": list(dataset_by_date_and_cont["County"]),
        "name": county
    }
    fig_dict["data"].append(data_dict)

# make frames
for Date in date_list:
    frame = {"data": [], "name": str(Date)}
    for county in counties:
        dataset_by_Date = df[df["Date"] == Date]
        dataset_by_Date_and_cont = dataset_by_Date[
            dataset_by_Date["County"] == county]

        data_dict = {
            "x": list(dataset_by_Date_and_cont["R mean"]),
            "error_x": dict(type='data',
                                             symmetric=False,
                                             array=dataset_by_Date_and_cont['R_plus'],
                                             arrayminus=dataset_by_Date_and_cont['R_minus'],
                                             thickness=0.5,
                                             ),
            "y": list(dataset_by_Date_and_cont["Daily Cases"]),
            "mode": "markers",
            "marker" : dict(size=np.log2(dataset_by_Date_and_cont['Population'])),
            "hovertemplate":dataset_by_Date_and_cont['County'] +
                                '<br>R Rate (mean): %{x:.2f}' +
                                '<br>Daily Cases: %{y}<br><extra></extra>',
            "text": list(dataset_by_Date_and_cont["County"]),
            "name": county
        }
        frame["data"].append(data_dict)

    fig_dict["frames"].append(frame)
    slider_step = {"args": [
        [Date],
        {"frame": {"duration": 300, "redraw": False},
         "mode": "immediate",
         "transition": {"duration": 300}}
    ],
        "label": Date,
        "method": "animate"}
    sliders_dict["steps"].append(slider_step)


fig_dict["layout"]["sliders"] = [sliders_dict]

fig = go.Figure(fig_dict)

fig.show()

# fig0 = go.Figure(data=go.Scatter(x=df['R mean'],
#                             y=df['Daily Cases'],
#                             error_x=dict(type='data',
#                                             symmetric=False,
#                                             array=df['R_plus'],
#                                             arrayminus=df['R_minus'],
#                                             thickness=0.5,
#                                             ),
#                             mode='markers',
#                             hovertemplate=df['County']+
#                                 '<br>R Rate (mean): %{x:.2f}' +
#                                 '<br>Daily Cases: %{y}<br><extra></extra>',
#             )
# )
# fig0.update_layout(
#     autosize=False,
#     width=900,
#     height=900,
#     hoverlabel=dict(
#         bgcolor="white",
#         font_size=16,
#         font_family="Rockwell",
#     ),
#     font_family="Ariel",
#     font_color='Black',
#     title={
#         'text': 'Pennsylvania Counties',
#         'font_size': 20,
#         'y': 0.95,
#         'x': 0.5,
#         'xanchor': 'center',
#         'yanchor': 'top'},
#     xaxis_title={
#         'text': "R rate",
#         'font_size': 16
#     },
#     yaxis_title={
#         'text': "Daily Cases per 100k (7 Day Average)",
#         'font_size': 16
#     },
#     shapes=[dict(
#         type='line',
#         x0=1,
#         x1=1,
#         y0=0,
#         y1=68,
#         line=dict(
#             color='Black',
#             dash='dash'))
#             ],
#     showlegend=False,
# )
# fig0.update_xaxes(
#     range=[0.2, 6]
# )
# fig0.update_yaxes(
#     range=(0, 68)
# )
# fig0.show()
