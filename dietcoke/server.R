library("dplyr")
library('rsconnect')
library("plyr")
library("httr")
library("jsonlite")
library("knitr")
library("ggplot2")
library("plotly")
library(RColorBrewer)

#crime <- read.csv("data/crime_dataset.csv", stringsAsFactors = F)

server <- function(input, output) {
  
  crime.plot <- crime %>% select(Victim.Age) 
  crime.plot <- crime[crime$Victim.Age < 98, ]
  
  output$hist<- renderPlot({
    
    hist(crime.plot$Victim.Age,
         probability = TRUE,
         breaks = as.numeric(input$bins),
         xlab = "Victim Ages",
         main = "Victim Ages",
         col= brewer.pal(8, "Blues"),
         border = "gray")
    
  })
  
  output$curve <- renderPlot({
    
    gg1 <- ggplot(crime, aes(x=Year,y = Incident, fill = Weapon))+
      geom_smooth()
    
    return(gg1)
  })
}

shinyServer(server)

