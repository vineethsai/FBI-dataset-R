library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

soursource('server.R')

shinyApp(ui=ui, server=server)
