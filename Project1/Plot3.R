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
#plot and save
png(file="Plot3.png",bg="white")
with(model3,plot(model3[,10],as.numeric(as.character(model3[,7])),type="n",xlab="",ylab="Energy sub metering"))
with(model3,lines(model3[,10],as.numeric(as.character(model3[,7])),col="black"))
with(model3,lines(model3[,10],as.numeric(as.character(model3[,8])),col="red"))
with(model3,lines(model3[,10],as.numeric(as.character(model3[,9])),col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()