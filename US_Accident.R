library(caret)
library(lattice)
library(ggplot2)
library(gridExtra)
library(ggpubr)
library(DataExplorer)
library(nnet)
library(randomForest)

#Reading dataset
library(readr)
dataset <- read_csv("US_Accidents_May19.csv")
  view(dataset)
head(dataset)

#Exploring dataset
summary(dataset)
attach(dataset)
#Removing null values
dataset <- dataset[!is.na(`Temperature(F)`) & !is.na(`Wind_Chill(F)`) 
                   & !is.na(`Humidity(%)`)  & !is.na(`Pressure(in)`)
                   & !is.na(`Visibility(mi)`) & !is.na(`Wind_Speed(mph)`) 
                   & !is.na(`Precipitation(in)`) & !is.na(`Wind_Direction`)
                   & !is.na(`Weather_Condition`), ]

#Dealing with categorical data
dataset[, c("Wind_Direction", "Weather_Timestamp", "Severity")]<-
  lapply(dataset[, c("Wind_Direction","Weather_Timestamp", "Severity")], factor)

dataset$Severity <- as.factor(dataset$Severity)

#Changing column names for simplicity
colnames(dataset)[colnames(dataset)=="Temperature(F)"] <- "Temperature"
colnames(dataset)[colnames(dataset)=="Wind_Chill(F)"] <- "Wind_Chill"
colnames(dataset)[colnames(dataset)=="Pressure(in)"] <- "Pressure"
colnames(dataset)[colnames(dataset)=="Visibility(mi)"] <- "Visibility"
colnames(dataset)[colnames(dataset)=="Wind_Speed(mph)"] <- "Wind_Speed"
colnames(dataset)[colnames(dataset)=="Precipitation(in)"] <- "Precipitation"
colnames(dataset)[colnames(dataset)=="Humidity(%)"] <- "Humidity"


ggplot(aes(x=Source), data=dataset)+
  geom_histogram(stat = "count", fill='navyblue', color='black')+
  ggtitle("Datasources")+
  theme(plot.margin = unit(c(1, 3, 1, 3), "cm"),
        text = element_text(size=10))

theme_set(theme_pubr())

#Adding weekday to the column
dataset$Weather_Timestamp <- weekdays(dataset$Weather_Timestamp)

dataset[, c("Weather_Timestamp")]<-
  lapply(dataset[, c("Weather_Timestamp")], factor)

#Setting order
dataset$Weather_Timestamp <- factor(dataset$Weather_Timestamp, 
                                    levels=c("Monday","Tuesday", "Wednesday",
                                             "Thursday","Friday","Saturday",
                                             "Sunday"))

colnames(dataset)[colnames(dataset)=="Weather_Timestamp"] <- "Weekday"

#Ploting Accidents by weekday
ggplot(aes(x=Weekday), data=dataset)+
  geom_histogram(stat = "count", fill='orangered2')+
  ggtitle(" Accidents by weekday")+
  theme(plot.margin = unit(c(1, 1, 1, 1), "cm"),
        text = element_text(size=10))

#Plotting Frequency distribution of US Accidents
ggplot(aes(x=State), data=dataset)+
  geom_histogram(stat = "count", fill='plum3')+
  ggtitle("Frequency distribution of US Accidents")+
  theme(text = element_text(size=8),axis.text.x=element_text(angle=90,hjust=0.1,vjust=0.5))

#Histograms and boxplots
g1<-ggplot(aes(x=Temperature), data=dataset)+
  geom_histogram(binwidth = 10, fill='brown2',color='black')+
  ggtitle("Histogram for Temperature(F)")+
  theme(text = element_text(size=8))
g2<-ggplot(data = dataset, aes(x = "", y = Temperature)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


g1<-ggplot(aes(x=Wind_Chill), data=dataset)+
  geom_histogram(binwidth = 10, fill='brown2',color='black')+
  ggtitle("Histogram for Wind_Chill(F)")+
  theme(text = element_text(size=8))
g2<-ggplot(data = dataset, aes(x = "", y = Wind_Chill)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


g1<-ggplot(aes(x=Humidity), data=dataset)+
  geom_histogram(binwidth = 10, fill='brown2',color='black')+
  ggtitle("Histogram for Humidity(%)")+
  theme(text = element_text(size=8))
g2<-ggplot(data = dataset, aes(x = "", y = Humidity)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


g1<-ggplot(aes(x=Pressure), data=dataset)+
  geom_histogram(binwidth = 0.1, fill='brown2',color='black')+
  ggtitle("Histogram for Pressure(in)")+
  theme(text = element_text(size=8))
g2<-ggplot(data = dataset, aes(x = "", y = Pressure)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


g1<-ggplot(aes(x=Visibility), data=dataset)+
  geom_histogram(binwidth = 1, fill='brown2',color='black')+
  ggtitle("Histogram for Visibility(mi)")+
  theme(text = element_text(size=8))
g2<-ggplot(data = dataset, aes(x = "", y = Visibility)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


g1<-ggplot(aes(x=Wind_Speed), data=dataset)+
  geom_histogram(binwidth = 0.1, fill='brown2',color='black')+
  ggtitle("Histogram for Wind_Speed(mph)")+
  theme(text = element_text(size=8))
g2<-ggplot(data = dataset, aes(x = "", y = Wind_Speed)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


g1<-ggplot(aes(x=Precipitation), data=dataset)+
  geom_histogram(binwidth = 0.05, fill='brown2',color='black')+
  ggtitle("Histogram for Precipitation(in)")+
  theme(text = element_text(size=8))
g2<-ggplot(data = dataset, aes(x = "", y = Precipitation)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


g1<-ggplot(aes(x=Weather_Condition), data=dataset)+
  geom_histogram(stat = "count", fill='brown2',color='black')+
  ggtitle("Histogram for Weather_Condition")+
  theme(text = element_text(size=8),
        axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
g2<-ggplot(data = dataset, aes(x = "", y = Weather_Condition)) +
  geom_boxplot(fill='cyan3',color='black')+
  theme(text = element_text(size=8))
grid.arrange(g1,g2,nrow=1)


ggplot(aes(x=Severity), data=dataset)+
  geom_histogram(stat = "count", fill='brown2',color='black')+
  ggtitle("Histogram for Severity")+
  theme(plot.margin = unit(c(1, 2, 1, 2), "cm"),
      text = element_text(size=10))


#splitting data into training and testing
bound <- floor((nrow(dataset)/4)*3)                   #define % of training and test set
dataset <- dataset[sample(nrow(dataset)), ]           #sample rows 
traindata <- dataset[1:bound, ]                       #get training set
testdata <- dataset[(bound+1):nrow(dataset), ]

#Multinomial regression

traindata$Severity <- as.factor(traindata$Severity)
testdata$Severity <- as.factor(testdata$Severity)

severity_mult <- multinom(Severity ~ Temperature+Wind_Chill+
                            Humidity+Pressure+Visibility+
                            Wind_Speed+Precipitation,
                         data = traindata)
summary(severity_mult)

# calculating z value
z <- summary(severity_mult)$coefficients/summary(severity_mult)$standard.errors
print(z)

# calculating p value
p <- (1 - pnorm(abs(z), 0, 1))*2
print(p)

#constructing confusin matrix
prediction_mult <- predict(severity_mult, newdata = testdata, type = 'class')
confusionMatrix(prediction_mult, testdata[["Severity"]])

# randomforest
set.seed(1)

rf_model <- randomForest(Severity ~ Temperature+Wind_Chill+
                           Humidity+Pressure+Visibility+
                           Wind_Speed+Precipitation,traindata)

rf_model
rf_result <- predict(rf_model, newdata = testdata[,!colnames(testdata) 
                                                  %in% c("Severity")])

# constructing confusin matrix
confusionMatrix(rf_result, testdata$Severity)
