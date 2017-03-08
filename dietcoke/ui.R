library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

year <- crime %>% select(Year)

ui <- fluidPage(

  titlePanel("American Homocide Rates by Race, Gender, and Age"),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput('size', 
                   "Point size",
                   min = 0.2,
                   max = 5,
                   value = 1)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot", fluidRow(plotOutput('plot', height = 250,
                                              click = 'plot_click',
                                              brush = brushOpts(
                                                id = "plot_brush")
                  )
                  ), 
                  fluidRow(
                    column(width = 6, 
                           h4("Points near click"),
                           verbatimTextOutput("click_info")
                    ),
                    column(width = 6,
                           h4("Brushed points"),
                           verbatimTextOutput("brush_info")
                    )
                  )
                  ),

                  tabPanel("Histogram"),
                  tabPanel("Map", fluidRow(plotOutput('map'))),
                  tabPanel("Pie Chart"))
    )
  )
)


shinyUI(ui)
