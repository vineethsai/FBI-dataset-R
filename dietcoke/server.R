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
crime <- read.csv("crime_dataset.csv", stringsAsFactors = F)
server <- function(input, output) {
   
  output$plot<- renderPlot({
    total.crime <- ddply(crime, c("State"), function(x){
      sum.inc <- sum(x$Incident)
      data.frame(sum.incident = sum.inc)
    })
    total.crime$State <- tolower(total.crime$State)
    states <- map_data("state")
    map.df<-merge(states, total.crime, by.x = "region", by.y = "State", all.x=T)
    map.df <- map.df[order(map.df$order),]
    map1 <- ggplot(map.df, aes(x=long,y=lat,group=group))+
      geom_polygon(aes(fill=sum.incident))+
      geom_path()+ ggtitle("Crime in the US")+
      scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
      coord_map()+theme_minimal()
    
   
  })
  
}

shinyServer(server)
