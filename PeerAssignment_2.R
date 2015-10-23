# Exploratory Data Analysis
# Peer Assignement 2
# 22/10/2015

# Libraries
setwd("~/Documents/Github/Exploratory Data Analysis Project 2")
list.files()
library(plyr)
library(ggplot2)

# load data
dfNEI <- readRDS("data/summarySCC_PM25.rds")
dfSCC <- readRDS("data/Source_Classification_Code.rds")

# Question 1 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
# Prepare dataframe
dfAggregate <- ddply(dfNEI, c("year"), summarize, totalEmissions = sum(Emissions))
dfAggregate
# Plotting
png("plot1.png",width=480,height=480,units="px",bg="transparent")
barplot((dfAggregate$totalEmissions)/10^6, 
    names.arg=dfAggregate$year,
    main = "Total emissions in the United States from 1999 to 2008", 
    xlab = "Year", 
    ylab = expression('Total PM'[2.5]*" emissions (10^6 tons)"),
    ylim=c(0,8),
    col="dodgerblue4")
dev.off()

# Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
dfAggregate = ddply(dfNEI[dfNEI$fips=="24510",], c("year"), summarize, totalEmissions = sum(Emissions))
dfAggregate
png("plot2.png",width=480,height=480,units="px",bg="transparent")
barplot((dfAggregate$totalEmissions)/10^3, 
        names.arg=dfAggregate$year,
        axes = T,
        main = "Total emissions in Baltimore City, Maryland from 1999 to 2008",
        xlab = "Year", 
        ylab = expression('Total PM'[2.5]*" emissions (10^3 tons)"),
        ylim=c(0,3.5),
        col="dodgerblue4")
dev.off()

# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
dfAggregate = ddply(dfNEI[dfNEI$fips=="24510",], c("year", "type"), summarize, totalEmissions = sum(Emissions))
dfAggregate
ggplot(dfAggregate,aes(factor(year), totalEmissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(.~type,scales = "free",space="free") + 
    theme_bw() + 
    guides(fill=FALSE) +
    labs(x="Year", y=expression("Emissions")) + 
    labs(title=expression("PM"[2.5]*" emissions, Baltimore City 1999-2008 by source type"))

# Question 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
cCoal <- grepl("coal", dfSCC$Short.Name, ignore.case = T)
cCoal <- as.character(dfSCC[cCoal, ]$SCC)
dfAggregate <- dfNEI[dfNEI$SCC %in% cCoal, ]
dfAggregate = ddply(dfAggregate, c("year"), summarize, totalEmissions=sum(Emissions))
barplot((dfAggregate$totalEmissions)/10^3, 
        names.arg=dfAggregate$year,
        axes = T,
        main = "Total coal related emissions from 1999 to 2008",
        xlab = "Year", 
        ylim=c(0,620),
        ylab = expression('Total PM'[2.5]*" emissions (10^3 tons)"),
        col="dodgerblue4")

# Question 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
cVehicle <- grepl("vehicle", dfSCC$SCC.Level.Two, ignore.case = T)
cVehicle <- as.character(dfSCC[cVehicle, ]$SCC)
dfAggregate <- dfNEI[dfNEI$SCC %in% cVehicle, ]
dfAggregate <- dfAggregate[dfAggregate$fips == "24510", ] 
dfAggregate = ddply(dfAggregate, c("year"), summarize, totalEmissions=sum(Emissions))
ggplot(dfAggregate, aes(factor(year), totalEmissions)) +
    geom_bar(stat="identity",fill="grey",width=0.8) +
    labs(title = "Total Emissions from Motor Vehicle Sources\nfrom 1999 to 2008", 
         x = "Year", 
         y = "Total Emissions")

# Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions
# subset the motor vehicles, which I assume is anything like Motor Vehicle in SCC.Level.Two
cVehicle <- grep("vehicle", dfSCC$SCC.Level.Two, ignore.case = T)
cVehicle <- as.character(dfSCC[cVehicle, ]$SCC)
dfAggregate <- dfNEI[dfNEI$SCC %in% cVehicle, ]
dfAggregate <- dfAggregate[dfAggregate$fips == "24510" | dfAggregate$fips == "06037", ] 
dfAggregate = ddply(dfAggregate, c("year", "fips"), summarize, totalEmissions=sum(Emissions))
dfAggregate[dfAggregate$fips == "06037","city"] = "Los Angeles County"
dfAggregate[dfAggregate$fips == "24510","city"] = "Baltimore City"
ggplot(dfAggregate, aes(year, totalEmissions, color = city)) +
geom_line(stat = "summary", fun.y = "sum") +
ylab(expression('Total PM'[2.5]*" emissions")) +
ggtitle("Comparison of total emissions From Motor\n Vehicle Sources in Baltimore City\n and Los Angeles County from 1999 to 2008") 

max(dfAggregate[dfAggregate$fips == "24510",]$totalEmissions)
max(dfAggregate[dfAggregate$fips == "06037",]$totalEmissions)

