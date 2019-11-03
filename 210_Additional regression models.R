# 210_Additional regression models 1.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

# add all the variables to a model to predict Temperature using original variables
model2 <- lm(Temperature ~ Gender + HeartRate, data=BodyTemperature)
summary(model2)

# add all the variables to a model to predict Temperature using original variables
model3 <- lm(Temperature ~ Gender + AGE1 + AGE2 + AGE3 + AGE4, data=BodyTemperature)
summary(model3)

# take out the age variables and add the heart ones
model4 <- lm(Temperature ~ Gender + HEART1 + HEART2 + HEART3 , data=BodyTemperature)
summary(model4)

# look at a coefficient plot
coefplot(model4)

layout(matrix(c(1, 2, 3, 4), 2, 2))
plot(model3, main = "Linear Regression Model")
