library("dplyr")
library('rsconnect')
library("httr")
library("jsonlite")
library("knitr")
library("ggplot2")

#crime <- read.csv("data/crime_dataset.csv", stringsAsFactors = F)

server <- function(input, output) {
  
  crime.plot <- crime %>% select(Victim.Age) 
  crime.plot <- crime[crime$Victim.Age < 98, ]
  
  output$hist<- renderPlot({
    
    hist(crime.plot$Victim.Age,
         probability = TRUE,
         breaks = as.numeric(input$bins),
         xlab = "Victim Ages",
         main = "Victim Ages")
  })
}

shinyServer(server)

