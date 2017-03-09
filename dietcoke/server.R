library("dplyr")
library('rsconnect')
library("maps")
library("mapproj")
library("plyr")
library("httr")
library("ggplot2")
library("tidyr")
library("mapdata")
library("plotly")
library("stringr")
library("shiny")
library("RColorBrewer")

crime <- read.csv("crime_dataset.csv", stringsAsFactors = F)

server <- function(input, output) {
  
  crime.plot <- crime %>% select(Perpetrator.Age, Incident) %>% filter(Perpetrator.Age != 0) %>% group_by(Perpetrator.Age) %>% summarise(Count = sum(Incident))
   output$plot <- renderPlot({
      ggplot(data = crime.plot, aes(Perpetrator.Age, Count)) +
        geom_point(size = input$size)
    })
  
  output$click_info <- renderPrint({
    nearPoints(crime.plot, input$plot_click, addDist = TRUE)
  })
  
  output$brush_info <- renderPrint({
    brushedPoints(crime.plot, input$plot_brush) 
  })
    
  output$map <- renderPlot({
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
   return(map1)
  })
  
  bar.data <- crime %>% select(Victim.Race, Year, Incident) %>% filter(Victim.Race != "Unknown")
  
  selected <- reactive({
    selected <- input$n
    bar.data <- crime[crime$Year == selected, ]
  })
  
  output$info <- renderText({
    crime <- selected()
    str2 <- paste0(c("During ", input$n), collapse = "")
    str1 <- paste0(" there were ", nrow(crime[crime$Victim.Race == "Black", ]), " black victims, ")
    str3 <- paste0(nrow(crime[crime$Victim.Race == "White", ]), " white victims, ")
    str4 <- paste0(nrow(crime[crime$Victim.Race == "Native American/Alaska Native", ]), " Native American or Alaska Native victims, ")
    str5 <- paste0(" and ", nrow(crime[crime$Victim.Race == "Asian/Pacific Islander", ]), " Asian/Pacific Islander victims.")
    paste0(str2, str1, str3, str4, str5)
  })
  
  # Victim Race
  output$plot1 <- renderPlot({
    plot1.data <- selected()
    plot1 <- ggplot(plot1.data) + geom_bar(aes(x = factor(""), fill = Victim.Race)) + coord_polar(theta = "y") + scale_x_discrete("") +
      ggtitle("Victim Race by Year") + labs(fill = "Victim Race")
    print(plot1)
  })
  
  crime.hist <- crime %>% select(Victim.Age) 
  crime.hist <- crime[crime$Victim.Age < 98, ]
  
  output$hist<- renderPlot({
    
    hist(crime.hist$Victim.Age,
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

