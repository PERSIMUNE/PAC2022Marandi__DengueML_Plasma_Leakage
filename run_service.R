### STARTING THE SERVICE
library("plumber")
r <- plumb("myservice.R")
r$run(host = "0.0.0.0",port=8001)