setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
optioner <- read_excel("../data/xl/SPXoptions.xlsx")
