import pandas as pd
import datetime

#today = date.today()
#date = today.strftime("%Y-%m-%d")
#yesterday = date - datetime.timedelta(days=1)
today = datetime.date.today()


yesterday = today - datetime.timedelta(days=1)
date = yesterday.strftime("%Y-%m-%d")
df = pd.read_csv('PA_time_series_data.csv')
dff = df.loc[df['Date'] == date]

dff = dff[dff.Admin2 != 'Out of PA']
dff = dff[dff.Admin2 != 'Unassigned']

df = pd.read_csv('PA_data.csv')
df2 = df[['county_name', 'fips', 'population']]
dailycases_p100k_7d_avg = dff[['7_day_avg']]
dailycases_p100k_7d_avg.reset_index(inplace = True)
dailycases_p100k_7d_avg.drop(columns = ['index'], inplace = True)
df2 = pd.concat([df2,dailycases_p100k_7d_avg], axis =1)
df2.rename(columns = {'7_day_avg' : 'dailycases_p100k_7d_avg'}, inplace = True)