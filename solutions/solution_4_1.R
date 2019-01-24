diamonds <- ggplot2::diamonds %>%
  mutate(value = if_else(price >= 4000,  "high", "low")) %>%
  mutate(id = row_number())
#Create training set
train <- diamonds  %>% sample_frac(.70)
#Create test set
test  <- anti_join(diamonds, train, by = 'id')


rpart(value ~ cut + carat + color + clarity,
      data = train,
      control = rpart.control(cp = 0.001))


dt1 <- rpart(value ~ cut + carat + color + clarity,
             data = train, control = rpart.control(cp = 0.001))
visTree(dt1)
# Prune the tree to remove unnecessary complexity from the model
dt2 <- prune(dt1, cp=0.1)
visTree(dt2)

pred <- predict(dt2,test, type = 'class')
mean(pred==test$value)
