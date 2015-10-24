# Exploratory Data Analysis
# Peer Assignement 2
# Oct-2015
# Question 6

source("LoadData.R")

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions
# I assume SCC.Level.Two is the correct column.
# Prepare dataframe
cVehicle = grep("vehicle", dfSCC$SCC.Level.Two, ignore.case = T)
cVehicle = as.character(dfSCC[cVehicle, ]$SCC)
dfAggregate = dfNEI[dfNEI$SCC %in% cVehicle, ]
dfAggregate = dfAggregate[dfAggregate$fips == "24510" | dfAggregate$fips == "06037", ] 
dfAggregate = ddply(dfAggregate, c("year", "fips"), summarize, totalEmissions=sum(Emissions))
dfAggregate[dfAggregate$fips == "06037","city"] = "Los Angeles County"
dfAggregate[dfAggregate$fips == "24510","city"] = "Baltimore City"
# Plot
png("plot6.png",width=480,height=480,units="px",bg="transparent")
ggplot(dfAggregate, aes(year, totalEmissions, color = city)) +
    geom_line(stat = "summary", fun.y = "sum") +
    ylab(expression('PM'[2.5]*" emissions")) +
    ggtitle("Comparison of total emissions from motor vehicle sources\n in Baltimore City\n and Los Angeles County from 1999 to 2008") 
dev.off()