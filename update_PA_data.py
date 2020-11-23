import pandas as pd
import datetime

df = pd.read_csv('4_weeks_PA_data.csv')
date = df['Date'].iloc[-1]

df = df[df['Date'] == date]
df.drop(columns = ['Unnamed: 0', 'Unnamed: 0.1'], inplace = True)
df.to_csv("PA_data_update.csv")