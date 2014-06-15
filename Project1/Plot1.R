
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
#change column 1 and 2 to date and time format
model1[,1] <- as.Date(model1[,1],format="%d/%m/%Y")
Time <- strptime(model1[,2],format="%H:%M:%S")
model1 <- cbind(model1[,1],Time,model1[,3:9])
#subset from '2007-02-01' to '2007-02-02'
model2 <- subset(model1, model1[,1]>='2007-02-01' & model1[,1]<='2007-02-02')
#plot histogram and save the file
png(file="Plot1.png",bg="white")
hist(as.numeric(as.character(model2[,"Global_active_power"])),col='red',main='Global Active Power',xlab='Global Active Power (kilowatts)')
dev.off()