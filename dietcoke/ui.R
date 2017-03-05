library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

ui <- fluidPage(

  titlePanel("American Homocide Rates by Race, Gender, and Age"),
  
  sidebarLayout(
    sidebarPanel(
      
       sliderInput("Year vs. ",
                   "Year",
                   min = 1980,
                   max = 2014,
                   value = 2000,
                   sep = "")
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot",fluidRow(plotOutput('plot')),
                  tabPanel("Histogram"),
                  tabPanel("Map"),
                  tabPanel("Pie Chart"))
    )
  )
))


shinyUI(ui)
