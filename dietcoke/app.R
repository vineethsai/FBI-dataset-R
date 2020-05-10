library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

source('ui.R')
source('server.R')

shinyApp(ui=ui, server=server)
