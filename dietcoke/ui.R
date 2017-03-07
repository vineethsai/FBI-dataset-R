library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

year <- crime %>% select(Year)

ui <- fluidPage(

  titlePanel("American Homocide Rates by Race, Gender, and Age"),
  
  sidebarLayout(
    sidebarPanel(
      
       sliderInput("year",
                   "Years:",
                   min = min(crime.plot$Year),
                   max = max(crime.plot$Year),
                   value = c(min(crime.plot$Year), max(crime.plot$Year)),
                   sep = ""),
       sliderInput('size', 
                   "Point size", 
                   min = 0.2, 
                   max = 5, 
                   value = 1)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot", fluidRow(plotOutput('plot'))),
                  tabPanel("Histogram"),
                  tabPanel("Map", fluidRow(plotOutput('map'))),
                  tabPanel("Pie Chart"))
    )
  )
)


shinyUI(ui)
