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
Adams_x <- subset(covid_data, Admin2 == 'Adams' & Confirmed >=1, select = Date)
Adams_date <- Adams_x$Date[8:length(Adams_x$Date)]

Adams_r <- data.frame(Adams_date,
                      Adams[["R"]][["Quantile.0.05(R)"]],
                      Adams[["R"]][["Mean(R)"]],
                      Adams[["R"]][["Quantile.0.95(R)"]])
colnames(Adams_r) <- c("Date", "0.05", "Mean", "0.95")

Allegheny_x <- subset(covid_data, Admin2 == 'Allegheny' & Confirmed >=1, select = Date)
Allegheny_date <- Allegheny_x$Date[8:length(Allegheny_x$Date)]

Allegheny_r <- data.frame(Allegheny_date,
                      Allegheny[["R"]][["Quantile.0.05(R)"]],
                      Allegheny[["R"]][["Mean(R)"]],
                      Allegheny[["R"]][["Quantile.0.95(R)"]])
colnames(Allegheny_r) <- c("Date", "0.05", "Mean", "0.95")

Armstrong_x <- subset(covid_data, Admin2 == 'Armstrong' & Confirmed >=1, select = Date)
Armstrong_date <- Armstrong_x$Date[8:length(Armstrong_x$Date)]

Armstrong_r <- data.frame(Armstrong_date,
                      Armstrong[["R"]][["Quantile.0.05(R)"]],
                      Armstrong[["R"]][["Mean(R)"]],
                      Armstrong[["R"]][["Quantile.0.95(R)"]])
colnames(Armstrong_r) <- c("Date", "0.05", "Mean", "0.95")

Beaver_x <- subset(covid_data, Admin2 == 'Beaver' & Confirmed >=1, select = Date)
Beaver_date <- Beaver_x$Date[8:length(Beaver_x$Date)]

Beaver_r <- data.frame(Beaver_date,
                      Beaver[["R"]][["Quantile.0.05(R)"]],
                      Beaver[["R"]][["Mean(R)"]],
                      Beaver[["R"]][["Quantile.0.95(R)"]])
colnames(Beaver_r) <- c("Date", "0.05", "Mean", "0.95")

Bedford_x <- subset(covid_data, Admin2 == 'Bedford' & Confirmed >=1, select = Date)
Bedford_date <- Bedford_x$Date[8:length(Bedford_x$Date)]

Bedford_r <- data.frame(Bedford_date,
                      Bedford[["R"]][["Quantile.0.05(R)"]],
                      Bedford[["R"]][["Mean(R)"]],
                      Bedford[["R"]][["Quantile.0.95(R)"]])
colnames(Bedford_r) <- c("Date", "0.05", "Mean", "0.95")

Berks_x <- subset(covid_data, Admin2 == 'Berks' & Confirmed >=1, select = Date)
Berks_date <- Berks_x$Date[8:length(Berks_x$Date)]

Berks_r <- data.frame(Berks_date,
                      Berks[["R"]][["Quantile.0.05(R)"]],
                      Berks[["R"]][["Mean(R)"]],
                      Berks[["R"]][["Quantile.0.95(R)"]])
colnames(Berks_r) <- c("Date", "0.05", "Mean", "0.95")

Blair_x <- subset(covid_data, Admin2 == 'Blair' & Confirmed >=1, select = Date)
Blair_date <- Blair_x$Date[8:length(Blair_x$Date)]

Blair_r <- data.frame(Blair_date,
                      Blair[["R"]][["Quantile.0.05(R)"]],
                      Blair[["R"]][["Mean(R)"]],
                      Blair[["R"]][["Quantile.0.95(R)"]])
colnames(Blair_r) <- c("Date", "0.05", "Mean", "0.95")

Bradford_x <- subset(covid_data, Admin2 == 'Bradford' & Confirmed >=1, select = Date)
Bradford_date <- Bradford_x$Date[8:length(Bradford_x$Date)]

Bradford_r <- data.frame(Bradford_date,
                      Bradford[["R"]][["Quantile.0.05(R)"]],
                      Bradford[["R"]][["Mean(R)"]],
                      Bradford[["R"]][["Quantile.0.95(R)"]])
colnames(Bradford_r) <- c("Date", "0.05", "Mean", "0.95")

Bucks_x <- subset(covid_data, Admin2 == 'Bucks' & Confirmed >=1, select = Date)
Bucks_date <- Bucks_x$Date[8:length(Bucks_x$Date)]

Bucks_r <- data.frame(Bucks_date,
                      Bucks[["R"]][["Quantile.0.05(R)"]],
                      Bucks[["R"]][["Mean(R)"]],
                      Bucks[["R"]][["Quantile.0.95(R)"]])
colnames(Bucks_r) <- c("Date", "0.05", "Mean", "0.95")

Butler_x <- subset(covid_data, Admin2 == 'Butler' & Confirmed >=1, select = Date)
Butler_date <- Butler_x$Date[8:length(Butler_x$Date)]

Butler_r <- data.frame(Butler_date,
                      Butler[["R"]][["Quantile.0.05(R)"]],
                      Butler[["R"]][["Mean(R)"]],
                      Butler[["R"]][["Quantile.0.95(R)"]])
colnames(Butler_r) <- c("Date", "0.05", "Mean", "0.95")

Cambria_x <- subset(covid_data, Admin2 == 'Cambria' & Confirmed >=1, select = Date)
Cambria_date <- Cambria_x$Date[8:length(Cambria_x$Date)]

Cambria_r <- data.frame(Cambria_date,
                      Cambria[["R"]][["Quantile.0.05(R)"]],
                      Cambria[["R"]][["Mean(R)"]],
                      Cambria[["R"]][["Quantile.0.95(R)"]])
colnames(Cambria_r) <- c("Date", "0.05", "Mean", "0.95")

Cameron_x <- subset(covid_data, Admin2 == 'Cameron' & Confirmed >=1, select = Date)
Cameron_date <- Cameron_x$Date[8:length(Cameron_x$Date)]

Cameron_r <- data.frame(Cameron_date,
                      Cameron[["R"]][["Quantile.0.05(R)"]],
                      Cameron[["R"]][["Mean(R)"]],
                      Cameron[["R"]][["Quantile.0.95(R)"]])
colnames(Cameron_r) <- c("Date", "0.05", "Mean", "0.95")

Carbon_x <- subset(covid_data, Admin2 == 'Carbon' & Confirmed >=1, select = Date)
Carbon_date <- Carbon_x$Date[8:length(Carbon_x$Date)]

Carbon_r <- data.frame(Carbon_date,
                      Carbon[["R"]][["Quantile.0.05(R)"]],
                      Carbon[["R"]][["Mean(R)"]],
                      Carbon[["R"]][["Quantile.0.95(R)"]])
colnames(Carbon_r) <- c("Date", "0.05", "Mean", "0.95")

Centre_x <- subset(covid_data, Admin2 == 'Centre' & Confirmed >=1, select = Date)
Centre_date <- Centre_x$Date[8:length(Centre_x$Date)]

Centre_r <- data.frame(Centre_date,
                      Centre[["R"]][["Quantile.0.05(R)"]],
                      Centre[["R"]][["Mean(R)"]],
                      Centre[["R"]][["Quantile.0.95(R)"]])
colnames(Centre_r) <- c("Date", "0.05", "Mean", "0.95")

Chester_x <- subset(covid_data, Admin2 == 'Chester' & Confirmed >=1, select = Date)
Chester_date <- Chester_x$Date[8:length(Chester_x$Date)]

Chester_r <- data.frame(Chester_date,
                      Chester[["R"]][["Quantile.0.05(R)"]],
                      Chester[["R"]][["Mean(R)"]],
                      Chester[["R"]][["Quantile.0.95(R)"]])
colnames(Chester_r) <- c("Date", "0.05", "Mean", "0.95")

Clarion_x <- subset(covid_data, Admin2 == 'Clarion' & Confirmed >=1, select = Date)
Clarion_date <- Clarion_x$Date[8:length(Clarion_x$Date)]

Clarion_r <- data.frame(Clarion_date,
                      Clarion[["R"]][["Quantile.0.05(R)"]],
                      Clarion[["R"]][["Mean(R)"]],
                      Clarion[["R"]][["Quantile.0.95(R)"]])
colnames(Clarion_r) <- c("Date", "0.05", "Mean", "0.95")

Clearfield_x <- subset(covid_data, Admin2 == 'Clearfield' & Confirmed >=1, select = Date)
Clearfield_date <- Clearfield_x$Date[8:length(Clearfield_x$Date)]

Clearfield_r <- data.frame(Clearfield_date,
                      Clearfield[["R"]][["Quantile.0.05(R)"]],
                      Clearfield[["R"]][["Mean(R)"]],
                      Clearfield[["R"]][["Quantile.0.95(R)"]])
colnames(Clearfield_r) <- c("Date", "0.05", "Mean", "0.95")

Clinton_x <- subset(covid_data, Admin2 == 'Clinton' & Confirmed >=1, select = Date)
Clinton_date <- Clinton_x$Date[8:length(Clinton_x$Date)]

Clinton_r <- data.frame(Clinton_date,
                      Clinton[["R"]][["Quantile.0.05(R)"]],
                      Clinton[["R"]][["Mean(R)"]],
                      Clinton[["R"]][["Quantile.0.95(R)"]])
colnames(Clinton_r) <- c("Date", "0.05", "Mean", "0.95")

Columbia_x <- subset(covid_data, Admin2 == 'Columbia' & Confirmed >=1, select = Date)
Columbia_date <- Columbia_x$Date[8:length(Columbia_x$Date)]

Columbia_r <- data.frame(Columbia_date,
                      Columbia[["R"]][["Quantile.0.05(R)"]],
                      Columbia[["R"]][["Mean(R)"]],
                      Columbia[["R"]][["Quantile.0.95(R)"]])
colnames(Columbia_r) <- c("Date", "0.05", "Mean", "0.95")

Crawford_x <- subset(covid_data, Admin2 == 'Crawford' & Confirmed >=1, select = Date)
Crawford_date <- Crawford_x$Date[8:length(Crawford_x$Date)]

Crawford_r <- data.frame(Crawford_date,
                      Crawford[["R"]][["Quantile.0.05(R)"]],
                      Crawford[["R"]][["Mean(R)"]],
                      Crawford[["R"]][["Quantile.0.95(R)"]])
colnames(Crawford_r) <- c("Date", "0.05", "Mean", "0.95")

Cumberland_x <- subset(covid_data, Admin2 == 'Cumberland' & Confirmed >=1, select = Date)
Cumberland_date <- Cumberland_x$Date[8:length(Cumberland_x$Date)]

Cumberland_r <- data.frame(Cumberland_date,
                      Cumberland[["R"]][["Quantile.0.05(R)"]],
                      Cumberland[["R"]][["Mean(R)"]],
                      Cumberland[["R"]][["Quantile.0.95(R)"]])
colnames(Cumberland_r) <- c("Date", "0.05", "Mean", "0.95")

Dauphin_x <- subset(covid_data, Admin2 == 'Dauphin' & Confirmed >=1, select = Date)
Dauphin_date <- Dauphin_x$Date[8:length(Dauphin_x$Date)]

Dauphin_r <- data.frame(Dauphin_date,
                      Dauphin[["R"]][["Quantile.0.05(R)"]],
                      Dauphin[["R"]][["Mean(R)"]],
                      Dauphin[["R"]][["Quantile.0.95(R)"]])
colnames(Dauphin_r) <- c("Date", "0.05", "Mean", "0.95")

Delaware_x <- subset(covid_data, Admin2 == 'Delaware' & Confirmed >=1, select = Date)
Delaware_date <- Delaware_x$Date[8:length(Delaware_x$Date)]

Delaware_r <- data.frame(Delaware_date,
                      Delaware[["R"]][["Quantile.0.05(R)"]],
                      Delaware[["R"]][["Mean(R)"]],
                      Delaware[["R"]][["Quantile.0.95(R)"]])
colnames(Delaware_r) <- c("Date", "0.05", "Mean", "0.95")

Elk_x <- subset(covid_data, Admin2 == 'Elk' & Confirmed >=1, select = Date)
Elk_date <- Elk_x$Date[8:length(Elk_x$Date)]

Elk_r <- data.frame(Elk_date,
                      Elk[["R"]][["Quantile.0.05(R)"]],
                      Elk[["R"]][["Mean(R)"]],
                      Elk[["R"]][["Quantile.0.95(R)"]])
colnames(Elk_r) <- c("Date", "0.05", "Mean", "0.95")

Erie_x <- subset(covid_data, Admin2 == 'Erie' & Confirmed >=1, select = Date)
Erie_date <- Erie_x$Date[8:length(Erie_x$Date)]

Erie_r <- data.frame(Erie_date,
                      Erie[["R"]][["Quantile.0.05(R)"]],
                      Erie[["R"]][["Mean(R)"]],
                      Erie[["R"]][["Quantile.0.95(R)"]])
colnames(Erie_r) <- c("Date", "0.05", "Mean", "0.95")

Fayette_x <- subset(covid_data, Admin2 == 'Fayette' & Confirmed >=1, select = Date)
Fayette_date <- Fayette_x$Date[8:length(Fayette_x$Date)]

Fayette_r <- data.frame(Fayette_date,
                      Fayette[["R"]][["Quantile.0.05(R)"]],
                      Fayette[["R"]][["Mean(R)"]],
                      Fayette[["R"]][["Quantile.0.95(R)"]])
colnames(Fayette_r) <- c("Date", "0.05", "Mean", "0.95")

Forest_x <- subset(covid_data, Admin2 == 'Forest' & Confirmed >=1, select = Date)
Forest_date <- Forest_x$Date[8:length(Forest_x$Date)]

Forest_r <- data.frame(Forest_date,
                      Forest[["R"]][["Quantile.0.05(R)"]],
                      Forest[["R"]][["Mean(R)"]],
                      Forest[["R"]][["Quantile.0.95(R)"]])
colnames(Forest_r) <- c("Date", "0.05", "Mean", "0.95")

Franklin_x <- subset(covid_data, Admin2 == 'Franklin' & Confirmed >=1, select = Date)
Franklin_date <- Franklin_x$Date[8:length(Franklin_x$Date)]

Franklin_r <- data.frame(Franklin_date,
                      Franklin[["R"]][["Quantile.0.05(R)"]],
                      Franklin[["R"]][["Mean(R)"]],
                      Franklin[["R"]][["Quantile.0.95(R)"]])
colnames(Franklin_r) <- c("Date", "0.05", "Mean", "0.95")

Fulton_x <- subset(covid_data, Admin2 == 'Fulton' & Confirmed >=1, select = Date)
Fulton_date <- Fulton_x$Date[8:length(Fulton_x$Date)]

Fulton_r <- data.frame(Fulton_date,
                      Fulton[["R"]][["Quantile.0.05(R)"]],
                      Fulton[["R"]][["Mean(R)"]],
                      Fulton[["R"]][["Quantile.0.95(R)"]])
colnames(Fulton_r) <- c("Date", "0.05", "Mean", "0.95")

Greene_x <- subset(covid_data, Admin2 == 'Greene' & Confirmed >=1, select = Date)
Greene_date <- Greene_x$Date[8:length(Greene_x$Date)]

Greene_r <- data.frame(Greene_date,
                      Greene[["R"]][["Quantile.0.05(R)"]],
                      Greene[["R"]][["Mean(R)"]],
                      Greene[["R"]][["Quantile.0.95(R)"]])
colnames(Greene_r) <- c("Date", "0.05", "Mean", "0.95")

Huntingdon_x <- subset(covid_data, Admin2 == 'Huntingdon' & Confirmed >=1, select = Date)
Huntingdon_date <- Huntingdon_x$Date[8:length(Huntingdon_x$Date)]

Huntingdon_r <- data.frame(Huntingdon_date,
                      Huntingdon[["R"]][["Quantile.0.05(R)"]],
                      Huntingdon[["R"]][["Mean(R)"]],
                      Huntingdon[["R"]][["Quantile.0.95(R)"]])
colnames(Huntingdon_r) <- c("Date", "0.05", "Mean", "0.95")

Indiana_x <- subset(covid_data, Admin2 == 'Indiana' & Confirmed >=1, select = Date)
Indiana_date <- Indiana_x$Date[8:length(Indiana_x$Date)]

Indiana_r <- data.frame(Indiana_date,
                      Indiana[["R"]][["Quantile.0.05(R)"]],
                      Indiana[["R"]][["Mean(R)"]],
                      Indiana[["R"]][["Quantile.0.95(R)"]])
colnames(Indiana_r) <- c("Date", "0.05", "Mean", "0.95")

Jefferson_x <- subset(covid_data, Admin2 == 'Jefferson' & Confirmed >=1, select = Date)
Jefferson_date <- Jefferson_x$Date[8:length(Jefferson_x$Date)]

Jefferson_r <- data.frame(Jefferson_date,
                      Jefferson[["R"]][["Quantile.0.05(R)"]],
                      Jefferson[["R"]][["Mean(R)"]],
                      Jefferson[["R"]][["Quantile.0.95(R)"]])
colnames(Jefferson_r) <- c("Date", "0.05", "Mean", "0.95")

Juniata_x <- subset(covid_data, Admin2 == 'Juniata' & Confirmed >=1, select = Date)
Juniata_date <- Juniata_x$Date[8:length(Juniata_x$Date)]

Juniata_r <- data.frame(Juniata_date,
                      Juniata[["R"]][["Quantile.0.05(R)"]],
                      Juniata[["R"]][["Mean(R)"]],
                      Juniata[["R"]][["Quantile.0.95(R)"]])
colnames(Juniata_r) <- c("Date", "0.05", "Mean", "0.95")

Lackawanna_x <- subset(covid_data, Admin2 == 'Lackawanna' & Confirmed >=1, select = Date)
Lackawanna_date <- Lackawanna_x$Date[8:length(Lackawanna_x$Date)]

Lackawanna_r <- data.frame(Lackawanna_date,
                      Lackawanna[["R"]][["Quantile.0.05(R)"]],
                      Lackawanna[["R"]][["Mean(R)"]],
                      Lackawanna[["R"]][["Quantile.0.95(R)"]])
colnames(Lackawanna_r) <- c("Date", "0.05", "Mean", "0.95")

Lancaster_x <- subset(covid_data, Admin2 == 'Lancaster' & Confirmed >=1, select = Date)
Lancaster_date <- Lancaster_x$Date[8:length(Lancaster_x$Date)]

Lancaster_r <- data.frame(Lancaster_date,
                      Lancaster[["R"]][["Quantile.0.05(R)"]],
                      Lancaster[["R"]][["Mean(R)"]],
                      Lancaster[["R"]][["Quantile.0.95(R)"]])
colnames(Lancaster_r) <- c("Date", "0.05", "Mean", "0.95")

Lawrence_x <- subset(covid_data, Admin2 == 'Lawrence' & Confirmed >=1, select = Date)
Lawrence_date <- Lawrence_x$Date[8:length(Lawrence_x$Date)]

Lawrence_r <- data.frame(Lawrence_date,
                      Lawrence[["R"]][["Quantile.0.05(R)"]],
                      Lawrence[["R"]][["Mean(R)"]],
                      Lawrence[["R"]][["Quantile.0.95(R)"]])
colnames(Lawrence_r) <- c("Date", "0.05", "Mean", "0.95")

Lebanon_x <- subset(covid_data, Admin2 == 'Lebanon' & Confirmed >=1, select = Date)
Lebanon_date <- Lebanon_x$Date[8:length(Lebanon_x$Date)]

Lebanon_r <- data.frame(Lebanon_date,
                      Lebanon[["R"]][["Quantile.0.05(R)"]],
                      Lebanon[["R"]][["Mean(R)"]],
                      Lebanon[["R"]][["Quantile.0.95(R)"]])
colnames(Lebanon_r) <- c("Date", "0.05", "Mean", "0.95")

Lehigh_x <- subset(covid_data, Admin2 == 'Lehigh' & Confirmed >=1, select = Date)
Lehigh_date <- Lehigh_x$Date[8:length(Lehigh_x$Date)]

Lehigh_r <- data.frame(Lehigh_date,
                      Lehigh[["R"]][["Quantile.0.05(R)"]],
                      Lehigh[["R"]][["Mean(R)"]],
                      Lehigh[["R"]][["Quantile.0.95(R)"]])
colnames(Lehigh_r) <- c("Date", "0.05", "Mean", "0.95")

Luzerne_x <- subset(covid_data, Admin2 == 'Luzerne' & Confirmed >=1, select = Date)
Luzerne_date <- Luzerne_x$Date[8:length(Luzerne_x$Date)]

Luzerne_r <- data.frame(Luzerne_date,
                      Luzerne[["R"]][["Quantile.0.05(R)"]],
                      Luzerne[["R"]][["Mean(R)"]],
                      Luzerne[["R"]][["Quantile.0.95(R)"]])
colnames(Luzerne_r) <- c("Date", "0.05", "Mean", "0.95")

Lycoming_x <- subset(covid_data, Admin2 == 'Lycoming' & Confirmed >=1, select = Date)
Lycoming_date <- Lycoming_x$Date[8:length(Lycoming_x$Date)]

Lycoming_r <- data.frame(Lycoming_date,
                      Lycoming[["R"]][["Quantile.0.05(R)"]],
                      Lycoming[["R"]][["Mean(R)"]],
                      Lycoming[["R"]][["Quantile.0.95(R)"]])
colnames(Lycoming_r) <- c("Date", "0.05", "Mean", "0.95")

McKean_x <- subset(covid_data, Admin2 == 'McKean' & Confirmed >=1, select = Date)
McKean_date <- McKean_x$Date[8:length(McKean_x$Date)]

McKean_r <- data.frame(McKean_date,
                      McKean[["R"]][["Quantile.0.05(R)"]],
                      McKean[["R"]][["Mean(R)"]],
                      McKean[["R"]][["Quantile.0.95(R)"]])
colnames(McKean_r) <- c("Date", "0.05", "Mean", "0.95")

Mercer_x <- subset(covid_data, Admin2 == 'Mercer' & Confirmed >=1, select = Date)
Mercer_date <- Mercer_x$Date[8:length(Mercer_x$Date)]

Mercer_r <- data.frame(Mercer_date,
                      Mercer[["R"]][["Quantile.0.05(R)"]],
                      Mercer[["R"]][["Mean(R)"]],
                      Mercer[["R"]][["Quantile.0.95(R)"]])
colnames(Mercer_r) <- c("Date", "0.05", "Mean", "0.95")

Mifflin_x <- subset(covid_data, Admin2 == 'Mifflin' & Confirmed >=1, select = Date)
Mifflin_date <- Mifflin_x$Date[8:length(Mifflin_x$Date)]

Mifflin_r <- data.frame(Mifflin_date,
                      Mifflin[["R"]][["Quantile.0.05(R)"]],
                      Mifflin[["R"]][["Mean(R)"]],
                      Mifflin[["R"]][["Quantile.0.95(R)"]])
colnames(Mifflin_r) <- c("Date", "0.05", "Mean", "0.95")

Monroe_x <- subset(covid_data, Admin2 == 'Monroe' & Confirmed >=1, select = Date)
Monroe_date <- Monroe_x$Date[8:length(Monroe_x$Date)]

Monroe_r <- data.frame(Monroe_date,
                      Monroe[["R"]][["Quantile.0.05(R)"]],
                      Monroe[["R"]][["Mean(R)"]],
                      Monroe[["R"]][["Quantile.0.95(R)"]])
colnames(Monroe_r) <- c("Date", "0.05", "Mean", "0.95")

Montgomery_x <- subset(covid_data, Admin2 == 'Montgomery' & Confirmed >=1, select = Date)
Montgomery_date <- Montgomery_x$Date[8:length(Montgomery_x$Date)]

Montgomery_r <- data.frame(Montgomery_date,
                      Montgomery[["R"]][["Quantile.0.05(R)"]],
                      Montgomery[["R"]][["Mean(R)"]],
                      Montgomery[["R"]][["Quantile.0.95(R)"]])
colnames(Montgomery_r) <- c("Date", "0.05", "Mean", "0.95")

Montour_x <- subset(covid_data, Admin2 == 'Montour' & Confirmed >=1, select = Date)
Montour_date <- Montour_x$Date[8:length(Montour_x$Date)]

Montour_r <- data.frame(Montour_date,
                      Montour[["R"]][["Quantile.0.05(R)"]],
                      Montour[["R"]][["Mean(R)"]],
                      Montour[["R"]][["Quantile.0.95(R)"]])
colnames(Montour_r) <- c("Date", "0.05", "Mean", "0.95")

Northampton_x <- subset(covid_data, Admin2 == 'Northampton' & Confirmed >=1, select = Date)
Northampton_date <- Northampton_x$Date[8:length(Northampton_x$Date)]

Northampton_r <- data.frame(Northampton_date,
                      Northampton[["R"]][["Quantile.0.05(R)"]],
                      Northampton[["R"]][["Mean(R)"]],
                      Northampton[["R"]][["Quantile.0.95(R)"]])
colnames(Northampton_r) <- c("Date", "0.05", "Mean", "0.95")

Northumberland_x <- subset(covid_data, Admin2 == 'Northumberland' & Confirmed >=1, select = Date)
Northumberland_date <- Northumberland_x$Date[8:length(Northumberland_x$Date)]

Northumberland_r <- data.frame(Northumberland_date,
                      Northumberland[["R"]][["Quantile.0.05(R)"]],
                      Northumberland[["R"]][["Mean(R)"]],
                      Northumberland[["R"]][["Quantile.0.95(R)"]])
colnames(Northumberland_r) <- c("Date", "0.05", "Mean", "0.95")

Perry_x <- subset(covid_data, Admin2 == 'Perry' & Confirmed >=1, select = Date)
Perry_date <- Perry_x$Date[8:length(Perry_x$Date)]

Perry_r <- data.frame(Perry_date,
                      Perry[["R"]][["Quantile.0.05(R)"]],
                      Perry[["R"]][["Mean(R)"]],
                      Perry[["R"]][["Quantile.0.95(R)"]])
colnames(Perry_r) <- c("Date", "0.05", "Mean", "0.95")

Philadelphia_x <- subset(covid_data, Admin2 == 'Philadelphia' & Confirmed >=1, select = Date)
Philadelphia_date <- Philadelphia_x$Date[8:length(Philadelphia_x$Date)]

Philadelphia_r <- data.frame(Philadelphia_date,
                      Philadelphia[["R"]][["Quantile.0.05(R)"]],
                      Philadelphia[["R"]][["Mean(R)"]],
                      Philadelphia[["R"]][["Quantile.0.95(R)"]])
colnames(Philadelphia_r) <- c("Date", "0.05", "Mean", "0.95")

Pike_x <- subset(covid_data, Admin2 == 'Pike' & Confirmed >=1, select = Date)
Pike_date <- Pike_x$Date[8:length(Pike_x$Date)]

Pike_r <- data.frame(Pike_date,
                      Pike[["R"]][["Quantile.0.05(R)"]],
                      Pike[["R"]][["Mean(R)"]],
                      Pike[["R"]][["Quantile.0.95(R)"]])
colnames(Pike_r) <- c("Date", "0.05", "Mean", "0.95")

Potter_x <- subset(covid_data, Admin2 == 'Potter' & Confirmed >=1, select = Date)
Potter_date <- Potter_x$Date[8:length(Potter_x$Date)]

Potter_r <- data.frame(Potter_date,
                      Potter[["R"]][["Quantile.0.05(R)"]],
                      Potter[["R"]][["Mean(R)"]],
                      Potter[["R"]][["Quantile.0.95(R)"]])
colnames(Potter_r) <- c("Date", "0.05", "Mean", "0.95")

Schuylkill_x <- subset(covid_data, Admin2 == 'Schuylkill' & Confirmed >=1, select = Date)
Schuylkill_date <- Schuylkill_x$Date[8:length(Schuylkill_x$Date)]

Schuylkill_r <- data.frame(Schuylkill_date,
                      Schuylkill[["R"]][["Quantile.0.05(R)"]],
                      Schuylkill[["R"]][["Mean(R)"]],
                      Schuylkill[["R"]][["Quantile.0.95(R)"]])
colnames(Schuylkill_r) <- c("Date", "0.05", "Mean", "0.95")

Snyder_x <- subset(covid_data, Admin2 == 'Snyder' & Confirmed >=1, select = Date)
Snyder_date <- Snyder_x$Date[8:length(Snyder_x$Date)]

Snyder_r <- data.frame(Snyder_date,
                      Snyder[["R"]][["Quantile.0.05(R)"]],
                      Snyder[["R"]][["Mean(R)"]],
                      Snyder[["R"]][["Quantile.0.95(R)"]])
colnames(Snyder_r) <- c("Date", "0.05", "Mean", "0.95")

Somerset_x <- subset(covid_data, Admin2 == 'Somerset' & Confirmed >=1, select = Date)
Somerset_date <- Somerset_x$Date[8:length(Somerset_x$Date)]

Somerset_r <- data.frame(Somerset_date,
                      Somerset[["R"]][["Quantile.0.05(R)"]],
                      Somerset[["R"]][["Mean(R)"]],
                      Somerset[["R"]][["Quantile.0.95(R)"]])
colnames(Somerset_r) <- c("Date", "0.05", "Mean", "0.95")

Sullivan_x <- subset(covid_data, Admin2 == 'Sullivan' & Confirmed >=1, select = Date)
Sullivan_date <- Sullivan_x$Date[8:length(Sullivan_x$Date)]

Sullivan_r <- data.frame(Sullivan_date,
                      Sullivan[["R"]][["Quantile.0.05(R)"]],
                      Sullivan[["R"]][["Mean(R)"]],
                      Sullivan[["R"]][["Quantile.0.95(R)"]])
colnames(Sullivan_r) <- c("Date", "0.05", "Mean", "0.95")

Susquehanna_x <- subset(covid_data, Admin2 == 'Susquehanna' & Confirmed >=1, select = Date)
Susquehanna_date <- Susquehanna_x$Date[8:length(Susquehanna_x$Date)]

Susquehanna_r <- data.frame(Susquehanna_date,
                      Susquehanna[["R"]][["Quantile.0.05(R)"]],
                      Susquehanna[["R"]][["Mean(R)"]],
                      Susquehanna[["R"]][["Quantile.0.95(R)"]])
colnames(Susquehanna_r) <- c("Date", "0.05", "Mean", "0.95")

Tioga_x <- subset(covid_data, Admin2 == 'Tioga' & Confirmed >=1, select = Date)
Tioga_date <- Tioga_x$Date[8:length(Tioga_x$Date)]

Tioga_r <- data.frame(Tioga_date,
                      Tioga[["R"]][["Quantile.0.05(R)"]],
                      Tioga[["R"]][["Mean(R)"]],
                      Tioga[["R"]][["Quantile.0.95(R)"]])
colnames(Tioga_r) <- c("Date", "0.05", "Mean", "0.95")

Union_x <- subset(covid_data, Admin2 == 'Union' & Confirmed >=1, select = Date)
Union_date <- Union_x$Date[8:length(Union_x$Date)]

Union_r <- data.frame(Union_date,
                      Union[["R"]][["Quantile.0.05(R)"]],
                      Union[["R"]][["Mean(R)"]],
                      Union[["R"]][["Quantile.0.95(R)"]])
colnames(Union_r) <- c("Date", "0.05", "Mean", "0.95")

Venango_x <- subset(covid_data, Admin2 == 'Venango' & Confirmed >=1, select = Date)
Venango_date <- Venango_x$Date[8:length(Venango_x$Date)]

Venango_r <- data.frame(Venango_date,
                      Venango[["R"]][["Quantile.0.05(R)"]],
                      Venango[["R"]][["Mean(R)"]],
                      Venango[["R"]][["Quantile.0.95(R)"]])
colnames(Venango_r) <- c("Date", "0.05", "Mean", "0.95")

Warren_x <- subset(covid_data, Admin2 == 'Warren' & Confirmed >=1, select = Date)
Warren_date <- Warren_x$Date[8:length(Warren_x$Date)]

Warren_r <- data.frame(Warren_date,
                      Warren[["R"]][["Quantile.0.05(R)"]],
                      Warren[["R"]][["Mean(R)"]],
                      Warren[["R"]][["Quantile.0.95(R)"]])
colnames(Warren_r) <- c("Date", "0.05", "Mean", "0.95")

Washington_x <- subset(covid_data, Admin2 == 'Washington' & Confirmed >=1, select = Date)
Washington_date <- Washington_x$Date[8:length(Washington_x$Date)]

Washington_r <- data.frame(Washington_date,
                      Washington[["R"]][["Quantile.0.05(R)"]],
                      Washington[["R"]][["Mean(R)"]],
                      Washington[["R"]][["Quantile.0.95(R)"]])
colnames(Washington_r) <- c("Date", "0.05", "Mean", "0.95")

Wayne_x <- subset(covid_data, Admin2 == 'Wayne' & Confirmed >=1, select = Date)
Wayne_date <- Wayne_x$Date[8:length(Wayne_x$Date)]

Wayne_r <- data.frame(Wayne_date,
                      Wayne[["R"]][["Quantile.0.05(R)"]],
                      Wayne[["R"]][["Mean(R)"]],
                      Wayne[["R"]][["Quantile.0.95(R)"]])
colnames(Wayne_r) <- c("Date", "0.05", "Mean", "0.95")

Westmoreland_x <- subset(covid_data, Admin2 == 'Westmoreland' & Confirmed >=1, select = Date)
Westmoreland_date <- Westmoreland_x$Date[8:length(Westmoreland_x$Date)]

Westmoreland_r <- data.frame(Westmoreland_date,
                      Westmoreland[["R"]][["Quantile.0.05(R)"]],
                      Westmoreland[["R"]][["Mean(R)"]],
                      Westmoreland[["R"]][["Quantile.0.95(R)"]])
colnames(Westmoreland_r) <- c("Date", "0.05", "Mean", "0.95")

Wyoming_x <- subset(covid_data, Admin2 == 'Wyoming' & Confirmed >=1, select = Date)
Wyoming_date <- Wyoming_x$Date[8:length(Wyoming_x$Date)]

Wyoming_r <- data.frame(Wyoming_date,
                      Wyoming[["R"]][["Quantile.0.05(R)"]],
                      Wyoming[["R"]][["Mean(R)"]],
                      Wyoming[["R"]][["Quantile.0.95(R)"]])
colnames(Wyoming_r) <- c("Date", "0.05", "Mean", "0.95")

York_x <- subset(covid_data, Admin2 == 'York' & Confirmed >=1, select = Date)
York_date <- York_x$Date[8:length(York_x$Date)]

York_r <- data.frame(York_date,
                      York[["R"]][["Quantile.0.05(R)"]],
                      York[["R"]][["Mean(R)"]],
                      York[["R"]][["Quantile.0.95(R)"]])
colnames(York_r) <- c("Date", "0.05", "Mean", "0.95")

write.csv(Adams_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Adams_r.csv")
write.csv(Allegheny_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Allegheny_r.csv")
write.csv(Armstrong_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Armstrong_r.csv")
write.csv(Beaver_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Beaver_r.csv")
write.csv(Bedford_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Bedford_r.csv")
write.csv(Berks_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Berks_r.csv")
write.csv(Blair_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Blair_r.csv")
write.csv(Bradford_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Bradford_r.csv")
write.csv(Bucks_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Bucks_r.csv")
write.csv(Butler_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Butler_r.csv")
write.csv(Cambria_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Cambria_r.csv")
write.csv(Cameron_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Cameron_r.csv")
write.csv(Carbon_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Carbon_r.csv")
write.csv(Centre_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Centre_r.csv")
write.csv(Chester_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Chester_r.csv")
write.csv(Clarion_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Clarion_r.csv")
write.csv(Clearfield_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Clearfield_r.csv")
write.csv(Clinton_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Clinton_r.csv")
write.csv(Columbia_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Columbia_r.csv")
write.csv(Crawford_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Crawford_r.csv")
write.csv(Cumberland_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Cumberland_r.csv")
write.csv(Dauphin_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Dauphin_r.csv")
write.csv(Delaware_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Delaware_r.csv")
write.csv(Elk_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Elk_r.csv")
write.csv(Erie_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Erie_r.csv")
write.csv(Fayette_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Fayette_r.csv")
write.csv(Forest_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Forest_r.csv")
write.csv(Franklin_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Franklin_r.csv")
write.csv(Fulton_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Fulton_r.csv")
write.csv(Greene_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Greene_r.csv")
write.csv(Huntingdon_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Huntingdon_r.csv")
write.csv(Indiana_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Indiana_r.csv")
write.csv(Jefferson_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Jefferson_r.csv")
write.csv(Juniata_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Juniata_r.csv")
write.csv(Lackawanna_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Lackawanna_r.csv")
write.csv(Lancaster_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Lancaster_r.csv")
write.csv(Lawrence_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Lawrence_r.csv")
write.csv(Lebanon_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Lebanon_r.csv")
write.csv(Lehigh_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Lehigh_r.csv")
write.csv(Luzerne_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Luzerne_r.csv")
write.csv(Lycoming_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Lycoming_r.csv")
write.csv(McKean_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/McKean_r.csv")
write.csv(Mercer_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Mercer_r.csv")
write.csv(Mifflin_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Mifflin_r.csv")
write.csv(Monroe_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Monroe_r.csv")
write.csv(Montgomery_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Montgomery_r.csv")
write.csv(Montour_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Montour_r.csv")
write.csv(Northampton_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Northampton_r.csv")
write.csv(Northumberland_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Northumberland_r.csv")
write.csv(Perry_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Perry_r.csv")
write.csv(Philadelphia_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Philadelphia_r.csv")
write.csv(Pike_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Pike_r.csv")
write.csv(Potter_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Potter_r.csv")
write.csv(Schuylkill_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Schuylkill_r.csv")
write.csv(Snyder_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Snyder_r.csv")
write.csv(Somerset_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Somerset_r.csv")
write.csv(Sullivan_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Sullivan_r.csv")
write.csv(Susquehanna_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Susquehanna_r.csv")
write.csv(Tioga_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Tioga_r.csv")
write.csv(Union_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Union_r.csv")
write.csv(Venango_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Venango_r.csv")
write.csv(Warren_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Warren_r.csv")
write.csv(Washington_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Washington_r.csv")
write.csv(Wayne_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Wayne_r.csv")
write.csv(Westmoreland_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Westmoreland_r.csv")
write.csv(Wyoming_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/Wyoming_r.csv")
write.csv(York_r, "C:/Users/Damien/Desktop/Data Science Projects/Pennsylvania-Covid-19-Dash/R files/York_r.csv")