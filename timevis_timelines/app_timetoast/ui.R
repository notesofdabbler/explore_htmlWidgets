library(timevis)
library(shiny)


fluidPage(
  titlePanel("Example Timelines with timevis Package"),
  tabsetPanel(type = "tabs",
      tabPanel("Walt Disney Pictures",
               p("The ",
                 a(href = " http://www.timetoast.com/timelines/walt-disney-studios-e3c9cdb3-5552-410b-a81f-1934f19444d9","Walt Disney Pictures timeline"),
                 " from timetoast site is recreated using ",
                 a(href="https://cran.r-project.org/web/packages/timevis/index.html","timevis")),
               br(),
               timevisOutput("timelineWD")       
               ),
      tabPanel("Airplanes",
               p("The ",
                a(href="https://www.timetoast.com/timelines/history-of-airplanes","Airplanes timeline")," from timetoast site is recreated using ",
                a(href="https://cran.r-project.org/web/packages/timevis/index.html","timevis")),
               timevisOutput("timelineAP")        
               )
              )
)