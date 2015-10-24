# Exploratory Data Analysis
# Peer Assignment 2
# Oct-2015
# plot3.R

source("LoadData.R")

# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
# Prepare dataframe
dfAggregate = ddply(dfNEI[dfNEI$fips=="24510",], c("year", "type"), summarize, totalEmissions = sum(Emissions))
dfAggregate
# Plot
png("plot3.png",width=480,height=480,units="px",bg="transparent")
ggplot(dfAggregate,aes(factor(year), totalEmissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(.~type,scales = "free",space="free") + 
    theme_bw() + 
    guides(fill=FALSE) +
    labs(x="Year", y=expression("Emissions")) + 
    labs(title=expression("PM"[2.5]*" emissions, Baltimore City 1999-2008 by source type"))
dev.off()
