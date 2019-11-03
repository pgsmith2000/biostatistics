# 001_Load data ahd create variables.R

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

# look for breakpoints in HeartRate
pretty_breaks(3)(BodyTemperature$HeartRate)

a <- ggplot(BodyTemperature, aes(HeartRate))
a + geom_histogram(aes(color=HeartRate), color="black", fill="#0CBDBD") +
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

# check structure
str(BodyTemperature)

# write the modified data to a file for convenience
write.csv(BodyTemperature, file="./data/bodytemperature_data.csv", row.names = FALSE)
