import pandas as pd

df = pd.read_csv(
    'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/'
    + 'csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv')
df = df[df['Province_State'] == 'Pennsylvania']
df.drop(columns=['UID', 'iso2', 'iso3', 'code3', 'Country_Region', 'Lat', 'Long_', 'Combined_Key'], inplace=True)

df = df.melt(id_vars=['FIPS', 'Admin2', 'Province_State'],
             var_name="Date",
             value_name="Confirmed"
             )

df['Date'] = pd.to_datetime(df['Date'])
df = df.sort_values(by=['Province_State', 'Admin2', 'Date'])

df['Daily Confirmed'] = df.groupby(['Province_State', 'Admin2'])['Confirmed'].diff().fillna(0)

df.loc[df['Daily Confirmed'] < 0, 'Daily Confirmed'] = 0

Rolling_average = df.groupby(['Admin2'])['Daily Confirmed'].rolling(7).mean()
Rolling_average = Rolling_average.fillna(0)
Avg_df = pd.DataFrame(Rolling_average)
Avg_df = Avg_df.rename(columns={'Daily Confirmed': '7_day_avg'})
Avg_df = Avg_df.reset_index()
Avg_df = Avg_df.set_index('level_1')

average = Avg_df['7_day_avg']
df = df.join(average)

dff = pd.read_csv(
    'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/'
    + 'csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv')
dff = dff[dff['Province_State'] == 'Pennsylvania']
dff.drop(columns=['UID', 'iso2', 'iso3', 'code3', 'Country_Region', 'Lat', 'Long_', 'Combined_Key'], inplace=True)

dff = dff.melt(id_vars=['FIPS', 'Admin2', 'Province_State', 'Population'],
               var_name="Date",
               value_name="Deaths"
               )

dff['Date'] = pd.to_datetime(dff['Date'])
dff = dff.sort_values(by=['Province_State', 'Admin2', 'Date'])

dff['Daily Deaths'] = dff.groupby(['Province_State', 'Admin2'])['Deaths'].diff().fillna(0)

dff.loc[dff['Daily Deaths'] < 0, 'Daily Deaths'] = 0
deaths = dff['Deaths']
ddeaths = dff['Daily Deaths']

df = df.join(deaths)
df = df.join(ddeaths)
df.to_csv('PA_time_series_data.csv')
