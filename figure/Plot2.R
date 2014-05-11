#set the url where is the dataset
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
#prepare destiny file
dest <- getwd()
dest <- paste(dest,sep="","/data1.zip")
#download .zip file
download.file(url,destfile=dest,method="curl")
#unzip file
unzip(dest,files="household_power_consumption.txt")
#prepare origin file fro read.csv function
orig <- getwd()
orig <- paste(orig,sep="","/household_power_consumption.txt")
#get data.frame
model1 <- read.csv(orig,header=T,sep=";")
#change column 1 to date format
model1[,1] <- as.Date(model1[,1],format="%d/%m/%Y")
#subset from '2007-02-01' to '2007-02-02'
model2 <- subset(model1, model1[,1]>='2007-02-01' & model1[,1]<='2007-02-02')
Date2 <- paste(model2[,1],model2[,2])
Date3 <- as.POSIXct(Date2,"%d/%m/%y %H:%M:%S")
model3 <- cbind(model2,Date3)
#plot nº2
png(file="Plot2.png",bg="white")
plot(model3[,10],model3[,3],type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
