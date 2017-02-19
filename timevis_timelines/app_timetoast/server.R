library(shiny)
library(timevis)

source("get_timelinedata.R")

function(input,output){
  output$timelineWD = renderTimevis(
    timevis(dataWD)
  )
  
  output$timelineAP = renderTimevis(
    timevis(dataAP)
  )
  
}