# 200_Regression model 1 1.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

# add all the variables to a model to predict Temperature using original variables
model1 <- lm(Temperature ~ Gender + Age + HeartRate, data=BodyTemperature)
summary(model1)

# look at a coefficient plot
coefplot(model1)

layout(matrix(c(1, 2, 3, 4), 2, 2))
plot(model1, main = "Linear Regression Model")

gvmodel <- gvlma(model1)
summary(model1)
gvmodel
