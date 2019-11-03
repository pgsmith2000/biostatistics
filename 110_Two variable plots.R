# 110_Two variable plots.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

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

