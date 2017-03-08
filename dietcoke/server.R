library("dplyr")
library('rsconnect')
library("maps")
library("mapproj")
library("plyr")
library("httr")
library("jsonlite")
library("knitr")
library("ggplot2")
library("tidyr")
library("mapdata")
library("plotly")
library("stringr")
crime <- read.csv("data/crime_dataset.csv", stringsAsFactors = F)

server <- function(input, output) {
  
  output$hist<- renderPlot({
  bins <- seq(min(x), max(x), length.out = input$bins + 1)
  
   p <- ggplot(data = crime, aes(x=crime$Victim.Age)) 
      + geom_histogram(binwidth = bins, color="grey", aes(fill=..count..))
    
    if(input$mean){p+ geom_vline(aes(xintercept=mean(crime$Victim.Age)),
                  color="white", linetype="dashed", size=1)
    }
    
  })
}

shinyServer(server)

