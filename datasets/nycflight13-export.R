######################################################################
# export data sets from R package nycflights13 
######################################################################

library(nycflights13); 

str(airlines);    # 16 rows 2 columns
str(airports);    # 1458 rows 8 columns 
str(flights);     # 336776 rows 19 columns 
str(planes);      # 3322 rows 9 columns 
str(weather);     # 26115 rows 15 columns 

write.csv(airlines, file = "airlines.csv", row.names = FALSE, na = "");
write.csv(airports, file = "airports.csv", row.names = FALSE, na = "");
write.csv(flights, file = "flights.csv", row.names = FALSE, na = "");
write.csv(planes, file = "planes.csv", row.names = FALSE, na = "");
write.csv(weather, file = "weather.csv", row.names = FALSE, na = "");

######################################################################
# THE END
######################################################################