# 002_Create data ictionary.R

# read in analytic table
BodyTemperature <- read.csv(file="./data/bodytemperature_data.csv", header=TRUE, sep=",")

# take a look at the structure of the table
str(BodyTemperature)

# take a look at the variables
summary(BodyTemperature)

# take a look as some other details from the original variables
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

