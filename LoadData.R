# Exploratory Data Analysis
# Peer Assignment 2
# Oct-2015
# LoadData.R

# Environment
Sys.setlocale("LC_TIME", "en_US")
setwd("~/Documents/Github/Exploratory Data Analysis - Course Project 2")

# Libraries
library(plyr)
library(ggplot2)

# Loading data
dfNEI = readRDS("data/summarySCC_PM25.rds")
dfSCC = readRDS("data/Source_Classification_Code.rds")
