import pandas as pd
import datetime

df = pd.read_csv('PA_data.csv')
df = df[['county_name', 'fips', 'population']]


dict_new_data = {}
for j in range(1,31):
    for i in df['county_name'].unique():
        df2 = pd.read_csv('R files/' + str(i) + '_r.csv')
        dict_new_data[i] = df2.iloc[-j]

    lst_mean = []
    for i in df['county_name'].unique():
        lst_mean.append(dict_new_data[i]['Mean'])
    lst_low = []
    for i in df['county_name'].unique():
        lst_low.append(dict_new_data[i]['0.05'])
    lst_high = []
    for i in df['county_name'].unique():
        lst_high.append(dict_new_data[i]['0.95'])
    
    date = dict_new_data['Adams']['Date']
    df['Date'] = date
    dff = pd.read_csv('PA_time_series_data.csv')
    dff = dff.loc[dff['Date'] == date]

    dff = dff[dff.Admin2 != 'Out of PA']
    dff = dff[dff.Admin2 != 'Unassigned']

    dailycases_p100k_7d_avg = list(dff['7_day_avg'])
    df['dailycases_p100k_7d_avg'] = dailycases_p100k_7d_avg
    df['R_mean'] = lst_mean
    df['R_low'] = lst_low
    df['R_high'] = lst_high

    df.to_csv('Date_files/PA_data_' + str(date) + '.csv')