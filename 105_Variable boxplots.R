# 105_Variables boxplots.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

p5 <- ggplot(BodyTemperature, aes(x=Gender, y=Age))
p5 <- p5 + geom_jitter(aes(color=Gender), size=2) + 
  geom_boxplot(aes(color=Gender), alpha=.6, size=1) +
  theme_minimal() +
  labs(title="Age by Gender")

p6 <- ggplot(BodyTemperature, aes(x=Gender, y=HeartRate))
p6 <- p6 + geom_jitter(aes(color=Gender), size=2) + 
  geom_boxplot(aes(color=Gender), alpha=.6, size=1) +
  theme_minimal() +
  labs(title="HeartRate by Gender")

p7 <- ggplot(BodyTemperature, aes(x=Gender, y=Temperature))
p7 <- p7 + geom_jitter(aes(color=Gender), size=2) + 
  geom_boxplot(aes(color=Gender), alpha=.6, size=1) +
  theme_minimal() +
  labs(title="Temp by Gender")

# print the plots in 2 x 2 format
grid.arrange(p5, p6, p7, nrow=2, ncol=3)

