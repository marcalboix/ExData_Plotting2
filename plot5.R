# Exploratory Data Analysis
# Peer Assignement 2
# Oct-2015
# plot5.R

source("LoadData.R")

# Question 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# I assume SCC.Level.Two is the correct column.
cVehicle <- grepl("vehicle", dfSCC$SCC.Level.Two, ignore.case = T)
cVehicle <- as.character(dfSCC[cVehicle, ]$SCC)
dfAggregate <- dfNEI[dfNEI$SCC %in% cVehicle, ]
dfAggregate <- dfAggregate[dfAggregate$fips == "24510", ] 
dfAggregate = ddply(dfAggregate, c("year"), summarize, totalEmissions=sum(Emissions))
png("plot5.png",width=480,height=480,units="px",bg="transparent")
ggplot(dfAggregate, aes(factor(year), totalEmissions)) +
    geom_bar(stat="identity",fill="grey",width=0.8) +
    labs(title = "Total emissions from motor vehicle sources\nfrom 1999 to 2008", 
         x = "Year", 
         y = "Total emissions")
dev.off()