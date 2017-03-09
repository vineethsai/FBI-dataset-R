library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

year <- crime %>% select(Year)

ui <- fluidPage(
  
  navbarPage("DietCoke Team",
    tabPanel("About",
      mainPanel(titlePanel("American Crime Data (1980 - 2014)")),
      fluidRow(
        column(6,
               h4("Based on national homicide reports across the United States from 1980 to 2014, we are examining the trends in this data by asking ourselves the following questions:"),
               h5(strong("Where does homicide occur the most often and why?")),
               h5(strong("Which race falls victim to the most homicides and why? What accounts for the change of this trend over time?")),
               h5(strong("At which age do most murders occur? Why is this?")),
               h5(strong("Which weapon is most often used? How can we make this less accessible to the public?")),
               h6("SOURCE: https://goo.gl/Y0nTdb (csv file)")
        ),
        column(3,
               img(class="crime-scene",
                   src=paste0("http://americanfreepress.net/wp-content/uploads/2012/04/crime-scene-tape-crop-300x231.jpg"),
                   
                   tags$small(
                     "Source: American Free Press ",
                     a(href= "http://americanfreepress.net/wp-content/uploads/2012/04/crime-scene-tape-crop-300x231.jpg")
                   )
               )
        )
      )
      ),

    navbarMenu("More",
          tabPanel("Vulnerable Age Groups (Histogram)",
                   sidebarLayout(
                   sidebarPanel(
                     selectInput(inputId = "bins",
                                 label = "Number of bins:",
                                 choices = c(10, 20, 35),
                                 selected = 20)),
                     
                   mainPanel(plotOutput('hist'),
                             h4("A histogram is able to visually represent the shape of the data. In our case, we focused on victim ages in which the data exemplify a right skewed set. Statistically, the data is able to pinpoint the median number of victim age which veers mostly towards the twenty through thirty age range. Furthermore, this is able to indicate that the median is lower than the mean victim age. In relation to the histogram visualization, the bin width adds depth into the knowledge of data ranges. Hence, we are able to gain further insight into the spread. The victim age is on wide range with a clear center around the younger ages. As for outliers, there is a slight increase in the beginning of the plot despite the general bell curve trend around the median of 22."))
                   )),
          
          tabPanel("Heat Map of Incidences", 
            h4("This map shows a heat map of the number of incidents of crime in the US. As you can see, there is a large number of crimes committed in Florida. We can attribute that to the crack/cocaine epidemic that occurred in the 80’s and 90’s. There was also a lot of crime in Illinois, California, and New York. This could be attributed to gang violence focused around the major cities of Chicago, LA, and NYC.", align = "center"),
            fluidRow(plotOutput('map'))),
          
          tabPanel("Trendline of Age Groups",
            sidebarLayout(
              sidebarPanel(
                sliderInput('size', 
                  "Point size",
                  min = 0.2,
                  max = 5,
                  value = 1)         
              ),
              mainPanel(
              fluidRow(plotOutput('plot', height = 250,
                                  click = 'plot_click',
                                  brush = brushOpts(
                                    id = "plot_brush")
              )
              ),
            
             fluidRow(column(width = 6, 
                h4("Points near click"),
                verbatimTextOutput("click_info")
                 ),
                 column(width = 6,
                  h4("Brushed points"),
                  verbatimTextOutput("brush_info")
                      )
                    ),
             h4("The scatter plot displays a relationship between different age groups and the count of incidences. The plot shows that the most amount of incidences occur at the common age 20.")
                 ))),
          
             tabPanel("Victim Race by Year", 
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("n", 'Year Displayed:', min = min(crime$Year), max = max(crime$Year), value = min(crime$Year), sep = "", step = 5)),
              mainPanel(h4("This chart displays the victim race per given year. If you progress from 1980 to 2014, you can see that the percentage of Black victims has increased from 40% to 50%. This is a huge increase in terms of total numbers of death, and it is indicative of social change. This could be attributed to the recent increase in gang violence, police violence, drugs, and overall feelings of unrest.", align = "center"),
              plotOutput("plot1"),
              verbatimTextOutput("info")
              )
       )
      ),
      tabPanel("Methods to Kill Over Time", plotOutput('curve'),
               h4("The weapon of choice over time has fluctuated between various means. A steady increase of firearms can be charted (shown in green). Around the line, there is a “cloud” representing the margin of error. It is interesting to point out the spike and drop in firearms around the mid 2000’s."))
     )
  )
)

  


shinyUI(ui)