library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

crime <- read.csv("data/crime_dataset.csv", stringsAsFactors = F)

ui <- fluidPage(

  titlePanel("American Homocide Rates by Race, Gender, and Age"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
   
       checkboxInput("mean",
                   "Add Meanline",
                   value = TRUE)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot"), 
                  tabPanel("Histogram", fluidRow(plotOutput('hist'))),
                  tabPanel("Map"),
                  tabPanel("Pie Chart"))
    )
  )
)


shinyUI(ui)

