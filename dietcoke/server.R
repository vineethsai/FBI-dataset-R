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
  library("plotly")
  library("stringr")
  #crime <- read.csv("crime_dataset.csv", stringsAsFactors = F)
  
  server <- function(input, output) ({

    bar.data <- crime %>% select(Victim.Race, Year, Incident) %>% filter(Victim.Race != "Unknown")
    
    selected <- reactive({
      selected <- input$n
      bar.data <- crime[crime$Year == selected, ]
    })
    
    output$info <- renderText({
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

    

  })
  
  shinyServer(server)
