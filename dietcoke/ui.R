library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

ui <- fluidPage(
  #crime <- read.csv("crime_dataset.csv", stringsAsFactors = F),

  titlePanel("American Homocide Rates by Race, Gender, and Age"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", 'Year Displayed:', min = min(crime$Year), max = max(crime$Year), value = min(crime$Year), sep = "", step = 5)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Pie Chart",

                  plotOutput("plot1"),
                  verbatimTextOutput("info")
                  )
      )
    )
  )
)


shinyUI(ui)
