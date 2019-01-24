setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
library(plotly)
library(broom)


avocados <- read_csv("../data/avocado.csv") %>%
  filter(region=="Albany") %>% 
  filter(type=="conventional")


# library(janitor)

avocados <- avocados %>% rename(totalvol = totalvol)

fit <- lm(AveragePrice~totalvol, data = avocados)

fit$coefficients
broom::tidy(fit)

avocados <- avocados %>% mutate(estimates = predict(fit, .))

plot(fit)

avocados %>% 
  plot_ly(x = ~totalvol, y= ~AveragePrice) %>% 
  add_trace(y=~estimates, mode = 'lines') %>% 
  add_trace(y=~AveragePrice)






###### PLOT #######

avocados %>% mutate(estimates = predict(IndsætModelHer,data = .)) %>% 
  select(AveragePrice,`Total Volume`,estimates) %>% 
  plot_ly(x= ~`Total Volume`, y = ~AveragePrice, mode="markers") %>%
  add_trace(y = ~estimates, mode = 'lines', name = "Estimate") %>% 
  add_trace(y = ~AveragePrice, mode = 'markers', name = "Actual")