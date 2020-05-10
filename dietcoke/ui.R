library('shiny')
library('ggplot2')
library('rsconnect')
library('dplyr')

year <- crime %>% select(Year)

ui <- fluidPage(theme = shinytheme("superhero"),
  
  navbarPage("FBI Crime Data Analysis",
    tabPanel("About",
      mainPanel(titlePanel("Investigating Crime Information in the United States from 1980 to 2014")),
      fluidRow(
        column(12,
               HTML("
              
<h2 id='-span-class-underline-motivation-and-background-span-'><span class='underline'>Motivation and Background:</span></h2>
<p>The recent spike in crimes caused by social unrest motivated us to
consider crime incidences –specifically homicides--and see what
inferences I can make about trends of the data. With a deteriorating
criminal justice system in the United States of America, I believe
that by using data analysis and big data we can come up with a more
effective system where marginalized and affected groups can be
protected beforehand.</p>
<p>Contrary to what Laurel Eckhouse - a researcher with the Human Rights
Data Analysis Group’s Policing Project, and a doctoral candidate in
political science at the University of California at Berkeley, who
believes that big data be reinforcing racial bias in criminal justice
system, I think these data-driven tools remove human bias from the
system, making it more fair as well as more effective.</p>
<p>As I write this paper, Big data is expanding to the criminal justice
systems. According to The Washington Post, in <a href='http://www.foxla.com/news/local-news/46625629-story'>Los
Angeles</a>, “police
use computerized “predictive policing” to anticipate crimes and
allocate officers. In <a href='https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing'>Fort
Lauderdale</a>,
Fla., machine-learning algorithms are used to set bond amounts. In
states across the country, <a href='https://fivethirtyeight.com/features/prison-reform-risk-assessment/'>data-driven
estimates</a> of
the risk of recidivism are being used to set jail sentences.”</p>
<p>I acknowledge that this method has a lot of drawbacks like data-driven
decision-making risks exacerbating, rather than eliminating, racial
bias in criminal justice. Black defendant is more likely to have a
prior conviction than the white one, despite identical conduct because
of racial biases in arrest and conviction rates. According to Laurel
Eckhouse, a risk assessment relying on racially compromised
criminal-history data will unfairly rate the black defendant as
riskier than the white defendant. Risk-assessment tools typically
evaluate their success in predicting a defendant’s dangerousness on
rearrests — not on defendants’ overall behavior after release. If our
two defendants return to the same neighborhood and continue their
identical lives, the black defendant is more likely to be
arrested. Thus, the tool will falsely appear to predict dangerousness
effectively, because the entire process is circular: Racial
disparities in arrests bias both the predictions and the justification
for those predictions.</p>
<p>But, these tools use archaic algorithms, which can and have to be
updated. With improved algorithms, we can accurately predict
marginalized groups in certain areas, and we can change policies,
improve the justice system by updating judges with the new information
and have a more inclusive and safe society.</p>
<p>In this paper, I tried to find trends based on demographics—such as if
a certain age, sex, or race is more likely to be affected than others,
then I can use the information to predict future cases. Additionally,
by looking at incidence rates of homicides, I can get a better idea of
which states have lower crime rates than others and to see if there
are generally different policies in certain states that have lower
homicide rates, then their policies may be implemented elsewhere to
reduce crime. I can also do the same for states that have very high
rates of homicide—what policies may or may not be in place in these
states that could cause these high rates? I was also curious to see if
there was a trend in weapons used overtime—to see if more guns and
automated weapons are used now than they were in 1980 or vice versa.</p>
<h2 id='-span-class-underline-summary-and-research-questions-span-'><span class='underline'>Summary and Research Questions:</span></h2>
<p>This research project considers trends and insights I can make from a
dataset that consists of information regarding homicides in the US
from 1980-2014. I would like to take a close look at demographics that
might be more at risk than others, as well as general trends such as
weapon type over time. In detail, these are my research questions and
the answers I arrived at after using my program to compute values:</p>
<p>1. What is the most common victim age, sex, and race affected in the
entire US?</p>
<p>2. What is the state which has the highest number of incidents? What
is the state with the lowest number?</p>
<p>3. Are specific relationships between perpetrator and victim more
susceptible? Such as wife- husband, or boyfriend-girlfriend?</p>
<p>4. Have controversial world events caused “spikes” in homicide rates?
If so, which events could be attributed to three biggest spikes in
incidents per month?</p>
<p>5. How do most common victim race, age, and sex vary between two
states? Such as Florida and</p>
<p>Washington? California and Georgia? How does victim race vary over all
the states?</p>
<p>6. Does the use of handguns as a murder weapon increase from 1980 to
2014?</p>
<h2 id='-span-class-underline-dataset-span-'><span class='underline'>Dataset:</span></h2>
<p>The Murder Accountability Project is the most complete database of
homicides in the United States currently available. This dataset
includes murders from the FBI&#39;s Supplementary Homicide Report from</p>
<p>1976 to the present and Freedom of Information Act data on more than
22,000 homicides that were not reported to the Justice Department.
This dataset includes the age, race, sex, ethnicity of victims and
perpetrators, in addition to the relationship between the victim and
perpetrator and weapon used.</p>
<p>• <a href='https://goo.gl/Y0nTdb'><span class='underline'>https://goo.gl/Y0nTdb</span>
(Ac</a>tual CSV file, need to download before
viewing)</p>
<p>My dataset has abundant information of each crime, with these factors
labeled for each incident, with a total of 638,455 cases:</p>
<table>
<thead>
<tr class='header'>
<th><blockquote>
<p>1.</p>
</blockquote></th>
<th><blockquote>
<p>Record number</p>
</blockquote></th>
<th><blockquote>
<p>13. Victim Age</p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr class='odd'>
<td><blockquote>
<p>2.</p>
</blockquote></td>
<td><blockquote>
<p>Agency Code</p>
</blockquote></td>
<td><blockquote>
<p>14. Victim Race</p>
</blockquote></td>
</tr>
<tr class='even'>
<td><blockquote>
<p>3.</p>
</blockquote></td>
<td><blockquote>
<p>Agency Name</p>
</blockquote></td>
<td><blockquote>
<p>15. Victim Ethnicity</p>
</blockquote></td>
</tr>
<tr class='odd'>
<td><blockquote>
<p>4.</p>
</blockquote></td>
<td><blockquote>
<p>Agency Type</p>
</blockquote></td>
<td><blockquote>
<p>16. Perpetrator Sex</p>
</blockquote></td>
</tr>
<tr class='even'>
<td><blockquote>
<p>5.</p>
</blockquote></td>
<td><blockquote>
<p>City</p>
</blockquote></td>
<td><blockquote>
<p>17. Perpetrator Age</p>
</blockquote></td>
</tr>
<tr class='odd'>
<td><blockquote>
<p>6.</p>
</blockquote></td>
<td><blockquote>
<p>State</p>
</blockquote></td>
<td><blockquote>
<p>18. Perpetrator Race</p>
</blockquote></td>
</tr>
<tr class='even'>
<td><blockquote>
<p>7.</p>
</blockquote></td>
<td><blockquote>
<p>Year</p>
</blockquote></td>
<td><blockquote>
<p>19. Perpetrator Ethnicity</p>
</blockquote></td>
</tr>
<tr class='odd'>
<td><blockquote>
<p>8.</p>
</blockquote></td>
<td><blockquote>
<p>Month</p>
</blockquote></td>
<td><blockquote>
<p>20. Relationship (between victim and perp.)</p>
</blockquote></td>
</tr>
<tr class='even'>
<td><blockquote>
<p>9.</p>
</blockquote></td>
<td><blockquote>
<p>Incident</p>
</blockquote></td>
<td><blockquote>
<p>21. Weapon</p>
</blockquote></td>
</tr>
<tr class='odd'>
<td><blockquote>
<p>10.</p>
</blockquote></td>
<td><blockquote>
<p>Crime Type</p>
</blockquote></td>
<td><blockquote>
<p>22. Victim Count</p>
</blockquote></td>
</tr>
<tr class='even'>
<td><blockquote>
<p>11.</p>
</blockquote></td>
<td><blockquote>
<p>Crime Solved</p>
</blockquote></td>
<td><blockquote>
<p>23. Perpetrator Count</p>
</blockquote></td>
</tr>
<tr class='odd'>
<td><blockquote>
<p>12.</p>
</blockquote></td>
<td><blockquote>
<p>Victim Sex</p>
</blockquote></td>
<td><blockquote>
<p>24. Record Source</p>
</blockquote></td>
</tr>
</tbody>
</table>

<h2 id='-span-class-underline-methodology-python-code-span-'><span class='underline'>Methodology (python code):</span></h2>
<h3 id='to-find-most-common-victim-age-race-and-sex-and-relationship-'>To find most common victim age, race, and sex, and relationship:</h3>
<p>1. First, look through each row of the file. Each row of the file
will include the column name with its respective value for that case
number. With my columns of interest being “Victim Age”, “Victim Sex”,
“Victim Race”, and “Relationship”, look through each row and find
the value associated with this column name. Accumulate values of each
row for these specific column names. For example, the “Victim age”
category would accumulate every single valid age.</p>
<p>2. Using the data points accumulated for each column, find the most
common value of the data points associated with each column of
interest.</p>
<h3 id='to-find-most-common-victim-age-race-sex-and-relationship-for-an-individual-state-'>To find most common victim age, race, sex, and relationship for an individual state:</h3>
<p>1. Using the same method as above, find the modes for selected
categories, but first categorize by state. Look through data file and
accumulate modes for each category for each state.</p>
<h3 id='for-finding-spikes-of-incidents-'>For finding spikes of incidents:</h3>
<p>1. First look through each row of the file—each row has the number of
incidents for that case number. For every year from 1980 to 2014
accumulate the total incidents per month for that year.</p>
<p>2. Using the incident values from month to month, compare each value
with next value. If the next value is equal to or greater than 150% of the previous value, then
that indicates that there is a spike in the data.</p>
<p>3. Record the months in which the spike took place between. For
example, if the total incidents for March totaled up to 150% times the
total incidents for February in the year 1991, record that there is a
spike from February to March of 1991.</p>
<h3 id='to-find-three-highest-spikes-'>To find three highest spikes:</h3>
<p>1. When you find that there is a “spike” between two months, keep
track of how much the count</p>
<p>increases by. The three highest differences are the three largest
spikes. To find if the use of handguns increases over time:</p>
<p>1. Look through each row of the file, find rows in which weapon type
used was “handgun”.</p>
<p>Accumulate total number of these cases for every year.</p>
<p>2. Plot graph of number of cases using handgun as weapon type vs.
year. Look at trend in graph to see if number of cases increases or
decreases.</p>
<h3 id='to-find-which-states-have-the-highest-number-of-incidents-'>To find which states have the highest number of incidents:</h3>
<p>1. Look through each row of the csv file. For every state accumulate
incident totals. Graph incident totals vs. state.</p>
<p>2. Look at the graph to see which states have highest incidents and
which states have lowest incidents.</p>
<h2 id='results'>Results</h2>
<h3 id='1-what-is-the-most-common-victim-age-sex-and-race-affected-in-the-entire-us-'>1. What is the most common victim age, sex, and race affected in the entire US?</h3>
<p><img src='media/i6.PNG' alt=''></p>
<p>From my data, I found that the most common
victim age was 22 at 3.66%, most common victim sex is Male at 77.51%,
and most common victim race was White at 50.24%. In theory that would
mean that the most at-risk demographic would be white males who are
around 22 years old. However, this does not take into consideration
the overall demographics of the United States. If this demographic is
prevalent through the entire US, that could skew this information as
they would naturally be the greatest at risk when simply looking at
chance. This information does not account for different regions of the
US, as there could be different demographics more at risk in different
parts of the US. Below are two graphs that show the number of
incidents for each sex, and number of incidents for ages 0-98.</p>
<h3 id='2-what-is-the-state-which-has-the-highest-number-of-incidents-what-is-the-state-with-the-lowest-number-'>2. What is the state which has the highest number of incidents? What is the state with the lowest number?</h3>
<p>The state with the highest total incidents from 1980 – 2014 was
Florida, and the state with the lowest number was North Dakota. North
Dakota was least only by a couple hundred counts from the states with
the second and third lowest incidents—which was not of much importance
to us. What I found interesting about this data was that the margin at
which Florida was the state with the highest incidents. Compared to
New York, the state with the second highest total incidents, Florida
was an increase of over</p>
<p>5,000,000 counts. This stood out to us, and I researched more into
homicides in Florida through the</p>
<p>1980’s to 2014. I discovered that Florida was a central part of drug
war that took place between Colombia and the US in the 1980’s. During
this time, there were record numbers of drug-related homicides in
South Florida, which could be a reason for this drastically high
incidence rate in this state.</p>
<p>Below is a graph of the incident count for every state in the US. This
graph shows better how there is a great difference between the states
with the first and second highest total incidents.</p>
<p><img src='media/i7.jpg' alt=''></p>
<h3 id='3-are-specific-relationships-between-perpetrator-and-victim-more-susceptible-such-as-wife-husband-or-boyfriend-girlfriend-'>3. Are specific relationships between perpetrator and victim more susceptible? Such as wife- husband, or boyfriend-girlfriend?</h3>
<p>The most common relationship that I found was “acquaintance,” meaning
that the victim and perpetrator may have known each other but were not
relatives, in a relationship, or close friends. This is important
because it shows that the likelihood of someone you do not know of
attacking you is low—it is more likely someone you have talked to or
know already. That might be frightening, but the overall chance of
this happening is in general relatively low.</p>
<h3 id='4-have-controversial-world-events-caused-spikes-in-homicide-rates-'>4. Have controversial world events caused “spikes” in homicide rates?</h3>
<p>If so, which event could be attributed to the highest increase in
homicides?</p>
<p>The three greatest spikes occurred from: November to December 1983,
February to March 2007, and</p>
<p>November to December 1980.</p>
<p>Originally, when I were looking for spikes in crime, I believed that I
would find periods of time which were spread apart and that could be
attributed to various causes and world events. Two of the spikes that
I found occurred within three years of each other, so I tried to look
rather at trends of events that occurred in those years rather than
looking at individual causes for these spikes. For the year</p>
<p>2007, I looked at specific events.</p>
<p>When doing my research as to what could have caused these spikes, I
found that starting from the</p>
<p>1980’s, gang-violence was heavily prominent, especially in urban
cities in the US. This caused a severe incline in violent crime in the
US and sparked action against gang-violence shortly after during the
late</p>
<p>1990’s. There was however, not any specific event that I found that
could be attributed to the two spikes in the early 80’s.</p>
<p>In 2007, there was a marked increase in violent crime. Criminologists
wrote about multiple theories as to why homicide rates were going back
up, and they suggested that the spike could be a result of an increase
in the juvenile population, growing numbers of released prison inmates
and the rise of serious gang problems in smaller jurisdictions.</p>
<p>Inserted below are the graphs for the years 1983 and 2007, where you
can clearly see the spikes. In the program, the graphs for all years
with spikes are saved, so you can look at those graphs as well.</p>
<p><img src='media/i8.PNG' alt=''></p>
<h3 id='5-how-do-most-common-victim-race-age-and-sex-vary-between-two-states-such-as-florida-and'>5. How do most common victim race, age, and sex vary between two states? Such as Florida and</h3>
<p>Washington? California and Maine? How does victim race vary over all
the states?</p>
<ol>
<li>Between Florida and Washington:</li>
</ol>
<p>i. Washington: Age: 22 at 3.47%, Race: White at 50.24%, Sex: Male at
77.51%</p>
<p>ii. Florida: Age: 25 at 3.30%, Race: White at 55.04%, Sex: Male at
75.31%</p>
<ol>
<li>Between California and Georgia:</li>
</ol>
<p>i. California: Age: 20 at 4.31%, Race: White at 66.08%, Sex: Male at
81.21%</p>
<p>ii. Georgia: Age: 23 at 3.62%, Race: Black at 67.90%, Sex: Male at
75.56%</p>
<p>When looking at the differences between the states chosen, it becomes
clear what demographics are at risk in various areas of the United
States. For example, when comparing what races are affected in
California and Georgia, two states on opposite sides of the country,
black people are more affected in Georgia compared to mostly white
people affected in California. Of course, this information has many
outlying circumstances—such as population demographics per state and
violence rates among different races in specific states, but this
gives us a general idea of what people are being affected in what
states. This is important, as this information can tell us who to
focus on when trying to predict crime across the US in different
states, and keep people safer country-wide.</p>
<h3 id='6-does-the-use-of-handguns-increase-over-time-'>6. Does the use of handguns increase over time?</h3>
<p>From the graph, I can see that the use of handguns decreases after a
sharp increase between the years</p>
<p>1988-1993. The rapid decline could be attributed to stricter gun laws,
as well as decline in drug-related crimes, which, from my research,
seemed to be a large proportion crimes which involved guns.
Additionally, with the prevalence of gang-activity in urban areas
during these years, the use of guns as a weapon in homicides was very
high. Long-term solutions were implemented these years—involving
reducing number of youth involved in gang activity, which could
attribute to this decline in gun use after the mid-90’s.</p>
<p><img src='media/i9.jpg' alt=''></p>
<h2 id='testing'>Testing</h2>
<p>To test my program, I created a smaller dataset called
“crime_data_small.csv” that consisted about only</p>
<p>15 rows out of the entire larger dataset with various state names,
ages, races, etc. This allowed us to initially manually calculate the
modes and frequencies that I were looking for, and make sure that the
results that I were getting out of the program were correct. Most of
my testing was done this way, in addition to print statements that I
inserted in the code throughout the process to see what values were
being computed and transferred to different data structures and
functions. Left in the code are some assert statements that ensure
that user input is valid.</p>
<p>I made sure that my graphs were accurate by graphing smaller datasets,
and again, doing the graphs ourselves by hand to make sure the output
graph looks the same as my hand drawn graphs. In the end, my results
are accurate, and I can assure that all values computed and graphed
are correct.</p>
<h2 id='references'>References</h2>
<ol>
<li><p>Pattavina, April. Information Technology and the Criminal Justice
System. Thousand Oaks, Calif.: Sage Publications, 2005. Web.</p>
</li>
<li><p>McKean, Jerome B., and Byers, Bryan. Data Analysis for Criminal
Justice and Criminology : Practice and Applications. Boston: Allyn
and Bacon, 2000. Web.</p>
</li>
<li><p>Eckhouse, Laurel. &quot;Big data may be reinforcing racial bias in the
criminal justice system.&quot; The Washington Post. 10 Feb 2016. Web. 27
May 2017.</p>
</li>
</ol>

                    ")
        ),
        # column(3,
        #        img(class="crime-scene",
        #            src=paste0("http://americanfreepress.net/wp-content/uploads/2012/04/crime-scene-tape-crop-300x231.jpg"),
        #            
        #            tags$small(
        #              "Source: American Free Press ",
        #              a(href= "http://americanfreepress.net/wp-content/uploads/2012/04/crime-scene-tape-crop-300x231.jpg")
        #            )
        #        )
        # )
      )
      ),

    # navbarMenu("More",
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
# )

  


shinyUI(ui)