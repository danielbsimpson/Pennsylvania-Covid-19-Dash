setwd("C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/")
covid_data <- read.csv('PA_time_series_data.csv')
covid_data <- covid_data[!(covid_data$Admin2=="Out of PA" | covid_data$Admin2 == "Unassigned"),]
#adams <- subset(covid_data, Admin2 == 'Adams' & Confirmed >= 1)
#adams$date <- as.Date(adams$Date , format = "%Y-%m-%d")
#df_adams <- data.frame(dates = adams$date, I = adams$Daily.Confirmed)
library(EpiEstim)
library(ggplot2)

print(unique(covid_data$Admin2))
for(i in unique(covid_data$Admin2)){
  assign(paste(i), estimate_R(data.frame(subset(covid_data, 
                                     Admin2 == i & Confirmed >= 1, 
                                     select = c(Daily.Confirmed))),
                              method = "parametric_si",
                              config = make_config(list(mean_si = 3.96,
                                                        std_si = 4.75))))
}
plot(Adams, "R")