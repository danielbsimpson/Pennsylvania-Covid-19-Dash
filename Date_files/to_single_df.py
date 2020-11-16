import pandas as pd
import glob

path = r'C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/Date_files' # use your path
all_files = glob.glob(path + "/*.csv")

li = []

for filename in all_files:
    df = pd.read_csv(filename, index_col=None, header=0)
    li.append(df)

frame = pd.concat(li, axis=0, ignore_index=True)
frame['Date']=pd.to_datetime(frame['Date'])
frame.sort_values(by = ['county_name', 'Date'], inplace= True)
frame.to_csv('4_weeks_PA_data.csv')