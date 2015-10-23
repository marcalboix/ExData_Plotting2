# Exploratory Data Analysis
# Peer Assignement 2
# Oct-2015
# plot4.R

source("LoadData.R")

# Question 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
cCoal <- grepl("coal", dfSCC$Short.Name, ignore.case = T)
cCoal <- as.character(dfSCC[cCoal, ]$SCC)
dfAggregate <- dfNEI[dfNEI$SCC %in% cCoal, ]
dfAggregate = ddply(dfAggregate, c("year"), summarize, totalEmissions=sum(Emissions))
png("plot4.png",width=480,height=480,units="px",bg="transparent")
barplot((dfAggregate$totalEmissions)/10^3, 
        names.arg=dfAggregate$year,
        axes = T,
        main = "Total coal related emissions\n from 1999 to 2008",
        xlab = "Year", 
        ylim=c(0,620),
        ylab = expression('Total PM'[2.5]*" emissions (10^3 tons)"),
        col="dodgerblue4")
dev.off()