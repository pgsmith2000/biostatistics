# 115__plot created variables 1.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

p11 <- ggplot(BodyTemperature, aes(AGEGRP))
p11 <- p11 + geom_bar(color="black", fill="#0CBDBD") +
  theme_minimal() +
  labs(title="Bar Chart of Age Groups")

p12 <- ggplot(BodyTemperature, aes(HEARTRATEGRP))
p12 <- p12 + geom_bar(color="black", fill="#0CBDBD") +
  theme_minimal() +
  labs(title="Bar Chart of Heart Rate Groups")

# print the plots in 2 x 2 format
grid.arrange(p11, p12, nrow=2, ncol=2)
