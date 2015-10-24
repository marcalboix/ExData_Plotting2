# Exploratory Data Analysis
# Peer Assignment 2
# Oct-2015
# plot1.R

source("LoadData.R")

# Question 1 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
# Prepare dataframe
dfAggregate = ddply(dfNEI, c("year"), summarize, totalEmissions = sum(Emissions))
# Plot
png("plot1.png",width=480,height=480,units="px",bg="transparent")
barplot((dfAggregate$totalEmissions)/10^6, 
        names.arg=dfAggregate$year,
        main = "Total emissions in the United States from 1999 to 2008", 
        xlab = "Year", 
        ylab = expression('Total PM'[2.5]*" emissions (10^6 tons)"),
        ylim=c(0,8),
        col="dodgerblue4")
dev.off()
