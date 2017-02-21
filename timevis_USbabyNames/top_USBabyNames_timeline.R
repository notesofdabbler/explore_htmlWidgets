
#
# Put top babynames by gender on a timeline using timevis
#

# load libraries
library(dplyr)
library(timevis)

# US Baby Names dataset from Kaggle Datasets
# https://www.kaggle.com/kaggle/us-baby-names
df = read.csv("timevis_USbabyNames/data/NationalNames.csv", stringsAsFactors = FALSE)

# Get top names by year for males and females
dftop = df %>% arrange(Gender, Year, desc(Count)) %>%
     group_by(Year, Gender) %>% filter(row_number() == 1)

# find contiguous year time frames when a name remains on top
dftop$new_name = ifelse(dftop$Name == lag(dftop$Name), 0, 1)
dftop$new_name[1] = 1

dftop$recnum = cumsum(dftop$new_name)
dftop2 = dftop %>% group_by(Gender, recnum, Name) %>% summarize(minyr = min(Year), maxyr = max(Year))

# get fields for timevis plotting
dftop2$start = as.Date(paste0(dftop2$minyr,"-01-01"))
dftop2$end = as.Date(paste0(dftop2$maxyr,"-12-31"))
dftop2$content = dftop2$Name

timevis(dftop2 %>% filter(Gender == "F"))
timevis(dftop2 %>% filter(Gender == "M"))

# Use content as html to allow for hover
gettxt = function(txt){
  sprintf('<p title = "%s">%s</p>',txt,txt)
}

gettxt(dftop2$Name[1])

dftop2$content = sapply(1:nrow(dftop2), function(i) gettxt(dftop2$Name[i]))

# include background color of boxes using style
dftop2$style = ifelse(dftop2$Gender == "F","background: pink;","background: lightblue;")

timevis(dftop2)

# group boxes by male vs female
dftop2$group = dftop2$Gender

groups = data.frame(id = c("F","M"), content = c("Female", "Male"))

timevis(dftop2, groups = groups)
