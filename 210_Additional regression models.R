# 210_Additional regression models 1.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

# add all the variables to a model to predict Temperature using original variables
model2 <- lm(Temperature ~ Gender + HeartRate, data=BodyTemperature)
summary(model2)

# add all the variables to a model to predict Temperature using original variables
model3 <- lm(Temperature ~ Gender + AGE1 + AGE2 + AGE3, data=BodyTemperature)
summary(model3)

# add all the variables to a model to predict Temperature using original variables
model4 <- lm(Temperature ~ Gender + AGE1 + AGE2, data=BodyTemperature)
summary(model4)

# take out the age variables and add the heart ones
model5 <- lm(Temperature ~ Gender + HEART1 + HEART2 + HEART3 , data=BodyTemperature)
summary(model5)

# take out the age variables and add the heart ones
model6 <- lm(Temperature ~ Gender + AGE1 + AGE2 + HEART1 + HEART2 , data=BodyTemperature)
summary(model6)

# take out the Gender
model7 <- lm(Temperature ~ AGE1 + AGE2 + HEART1 + HEART2 , data=BodyTemperature)
summary(model7)

summary(model1)$adj.r.squared
summary(model2)$adj.r.squared
summary(model3)$adj.r.squared
summary(model4)$adj.r.squared
summary(model5)$adj.r.squared
summary(model6)$adj.r.squared
summary(model7)$adj.r.squared

# look at a coefficient plot
coefplot(model6)

layout(matrix(c(1, 2, 3, 4), 2, 2))
plot(model4, main = "Linear Regression Model")

gvmodel <- gvlma(model6)
summary(model6)
gvmodel

