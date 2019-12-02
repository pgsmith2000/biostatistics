# 100_Plot individual variables.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

# create bar chart and histograms of all variables
# Gender
p1 <- ggplot(BodyTemperature, aes(Gender, fill=Gender))
p1 <- p1 + geom_bar(aes(Gender), color="black") +
  scale_fill_manual(values=c("#E8706A", "#0CBDBD")) +
  theme_minimal() +
  labs(title="Participant Gender")

# Age
p2 <- ggplot(BodyTemperature, aes(Age))
p2 <- p2 + geom_histogram(aes(color=Age), color="black", fill="#0CBDBD") +
  theme_minimal() +
  labs(title="Participant Age")

# HeartRate
p3 <- ggplot(BodyTemperature, aes(HeartRate))
p3 <- p3 + geom_histogram(aes(color=HeartRate), color="black", fill="#0CBDBD") +
  theme_minimal() +
  labs(title="HeartRate")

# Body Temperature
p4 <- ggplot(BodyTemperature, aes(Temperature))
p4 <- p4 + geom_histogram(aes(color=Temperature), color="black", fill="#0CBDBD") +
  theme_minimal() +
  labs(title="Body Temperature")

# print the plots in 2 x 2 format
grid.arrange(p1, p2, p3, p4, nrow=2, ncol=2)

