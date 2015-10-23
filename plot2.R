# Exploratory Data Analysis
# Peer Assignement 2
# Oct-2015
# plot2.R

source("LoadData.R")

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