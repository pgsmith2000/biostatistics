# load libraries
library(scales)
library(Hmisc)
library(e1071)
library(psych)
library(ggplot2)
library(gridExtra)
library(arm)
library(gvlma)


# read in data set
BodyTemperature <- read.csv("./data/BodyTemperature.txt", header = TRUE, sep = " ")

summary(BodyTemperature$Age)

# Create a stratefied (categorical age variable)
BodyTemperature$AGEGRP <- 9
BodyTemperature$AGEGRP[BodyTemperature$Age < 25] <- 1
BodyTemperature$AGEGRP[BodyTemperature$Age > 24 & BodyTemperature$Age < 35] <- 2
BodyTemperature$AGEGRP[BodyTemperature$Age > 34 & BodyTemperature$Age < 45] <- 3
BodyTemperature$AGEGRP[BodyTemperature$Age > 44] <- 4

table(BodyTemperature$AGEGRP)
BodyTemperature$AGEGRP <- as.factor(BodyTemperature$AGEGRP)

BodyTemperature$AGE1 <- 0
BodyTemperature$AGE2 <- 0
BodyTemperature$AGE3 <- 0
BodyTemperature$AGE4 <- 0

BodyTemperature$AGE1[BodyTemperature$Age < 25] <- 1
BodyTemperature$AGE2[BodyTemperature$Age > 24 & BodyTemperature$Age < 35] <- 1
BodyTemperature$AGE3[BodyTemperature$Age > 34 & BodyTemperature$Age < 45] <- 1
BodyTemperature$AGE4[BodyTemperature$Age > 44 & BodyTemperature$Age < 55] <- 1

table(BodyTemperature$AGEGRP, BodyTemperature$AGE1)
table(BodyTemperature$AGEGRP, BodyTemperature$AGE2)
table(BodyTemperature$AGEGRP, BodyTemperature$AGE3)
table(BodyTemperature$AGEGRP, BodyTemperature$AGE4)

# check structure
str(BodyTemperature)

summary(BodyTemperature)

sapply(BodyTemperature[2:4], function(x) c( "Stand dev" = sd(x), 
                         "Mean"= mean(x,na.rm=TRUE),
                         "n" = length(x),
                         "Median" = median(x),
                         "CoeffofVariation" = sd(x)/mean(x,na.rm=TRUE),
                         "Minimum" = min(x),
                         "Maximun" = max(x),
                         "Upper Quantile" = quantile(x,1),
                         "LowerQuartile" = quantile(x,0))
)

# create a textfile data dictionary
data_dictionary <- Hmisc::describe((BodyTemperature))
sink("./data/BodyTemperature_data_dictionary.txt", append=TRUE)
data_dictionary
sink()

# another way to describe
psych::describe(BodyTemperature)

# create bar chart and histograms of all variables
# Gender
p1 <- ggplot(BodyTemperature, aes(Gender))
p1 <- p1 + geom_bar(fill = "steelblue", color ="steelblue") +
  theme_minimal() +
  labs(title="Bar Chart of Gender")

# Age
p2 <- ggplot(BodyTemperature, aes(Age))
p2 <- p2 + geom_histogram(aes(color=Age), color="darkblue", fill="steelblue") +
  theme_minimal() +
  labs(title="Histogram of Age")

# HeartRate
p3 <- ggplot(BodyTemperature, aes(HeartRate))
p3 <- p3 + geom_histogram(aes(color=HeartRate), color="darkblue", fill="steelblue") +
  theme_minimal() +
  labs(title="Histogram of HeartRate")

# Body Temperature
p4 <- ggplot(BodyTemperature, aes(Temperature))
p4 <- p4 + geom_histogram(aes(color=Temperature), color="darkblue", fill="steelblue") +
  theme_minimal() +
  labs(title="Histogram of Temperature")

# print the plots in 2 x 2 format
grid.arrange(p1, p2, p3, p4, nrow=2, ncol=2)

# look for breakpoints in HeartRate
pretty_breaks(3)(BodyTemperature$HeartRate)

p3 <- ggplot(BodyTemperature, aes(HeartRate))
p3 + geom_histogram(aes(color=HeartRate), color="darkblue", fill="steelblue") +
  geom_vline(xintercept = 70) +
  geom_vline(xintercept = 80) 

# Create a stratefied (categorical heartrate variable)
BodyTemperature$HEARTRATEGRP <- 9
BodyTemperature$HEARTRATEGRP[BodyTemperature$HeartRate < 71] <- 1
BodyTemperature$HEARTRATEGRP[BodyTemperature$HeartRate > 70 & BodyTemperature$HeartRate < 81] <- 2
BodyTemperature$HEARTRATEGRP[BodyTemperature$HeartRate > 80] <- 3

table(BodyTemperature$HEARTRATEGRP)
BodyTemperature$HEARTRATEGRP <- as.factor(BodyTemperature$HEARTRATEGRP)

BodyTemperature$HEART1 <- 0
BodyTemperature$HEART2 <- 0
BodyTemperature$HEART3 <- 0

BodyTemperature$HEART1[BodyTemperature$HEARTRATEGRP == 1] <- 1
BodyTemperature$HEART2[BodyTemperature$HEARTRATEGRP == 2] <- 1
BodyTemperature$HEART3[BodyTemperature$HEARTRATEGRP == 3] <- 1


table(BodyTemperature$HEARTRATEGRP, BodyTemperature$HEART1)
table(BodyTemperature$HEARTRATEGRP, BodyTemperature$HEART2)
table(BodyTemperature$HEARTRATEGRP, BodyTemperature$HEART3)

p5 <- ggplot(BodyTemperature, aes(x=Gender, y=Age))
p5 <- p5 + geom_jitter(aes(color=Gender), size=2) + 
  geom_boxplot(aes(color=Gender), alpha=.6, size=1) +
  theme_minimal() +
  labs(title="Boxplot of Age by Gender")

p6 <- ggplot(BodyTemperature, aes(x=Gender, y=HeartRate))
p6 <- p6 + geom_jitter(aes(color=Gender), size=2) + 
  geom_boxplot(aes(color=Gender), alpha=.6, size=1) +
  theme_minimal() +
  labs(title="Boxplot of HeartRate by Gender")
  
p7 <- ggplot(BodyTemperature, aes(x=Gender, y=Temperature))
p7 <- p7 + geom_jitter(aes(color=Gender), size=2) + 
  geom_boxplot(aes(color=Gender), alpha=.6, size=1) +
  theme_minimal() +
  labs(title="Boxplot of Temperature by Gender")

# print the plots in 2 x 2 format
grid.arrange(p5, p6, p7, nrow=2, ncol=3)


p8 <- ggplot(BodyTemperature, aes(x = Age, y = HeartRate, color=Gender))
p8 <- p8 + geom_point(size=2) +
  geom_smooth()

p9 <- ggplot(BodyTemperature, aes(x = Age, y = Temperature, color=Gender))
p9 <- p9 + geom_point(size=2) +
  geom_smooth()

p10 <- ggplot(BodyTemperature, aes(x = HeartRate, y =Temperature , color=Gender))
p10 <- p10 + geom_point(size=2) +
  geom_smooth()

# print the plots in 2 x 2 format
grid.arrange(p8, p9, p10, nrow=2, ncol=2)

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

# add all the variables to a model to predict Temperature using original variables
model2 <- lm(Temperature ~ Gender + HeartRate, data=BodyTemperature)
summary(model2)

p11 <- ggplot(BodyTemperature, aes(AGEGRP))
p11 <- p11 + geom_bar(fill = "steelblue", color ="steelblue") +
  theme_minimal() +
  labs(title="Bar Chart of Age Groups")

p12 <- ggplot(BodyTemperature, aes(HEARTRATEGRP))
p12 <- p12 + geom_bar(fill = "steelblue", color ="steelblue") +
  theme_minimal() +
  labs(title="Bar Chart of Heart Rate Groups")

# print the plots in 2 x 2 format
grid.arrange(p11, p12, nrow=2, ncol=2)

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
