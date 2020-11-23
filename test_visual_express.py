import plotly.express as px
import pandas as pd

df = pd.read_csv("4_weeks_PA_data.csv")

df['R_minus'] = df['R_mean'] - df['R_low']
df['R_plus'] = df['R_high'] - df['R_mean']

y_max = df["dailycases_p100k_7d_avg"].max()

fig = px.scatter(df, x="R_mean", y="dailycases_p100k_7d_avg", animation_frame="Date", animation_group="county_name",
                size="population", color="county_name", hover_name="county_name",
                size_max=20, range_x=[0,4], range_y=[0,y_max],
                error_x= "R_plus", error_x_minus= "R_minus")
fig.add_shape(type="line",
    x0=1, y0=0, x1=1, y1=y_max,
    line=dict(
        color="LightSeaGreen",
        width=4,
        dash="dashdot",
    )
)
fig.show()