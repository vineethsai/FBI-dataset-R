library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

#crime <- read.csv("data/crime_dataset.csv", stringsAsFactors = F)

ui <- fluidPage(
  
  titlePanel("American Homocide Rates by Race, Gender, and Age"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "bins",
                  label = "Number of bins:",
                  choices = c(10, 20, 35, 50),
                  selected = 20)),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot"), 
                  tabPanel("Histogram", plotOutput('hist')),
                  tabPanel("Map"),
                  tabPanel("Pie Chart"))
    )
  )
)


shinyUI(ui)

