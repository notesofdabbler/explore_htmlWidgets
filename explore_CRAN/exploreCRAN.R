# load libraries
library(dygraphs)
library(xts)
library(cranlogs)
library(dplyr)
library(timevis)

#
# Get data on cran packages by first release date
# Taken from analysis that was reported by Revolution blog and done by Gergely Daróczi
# http://blog.revolutionanalytics.com/2017/01/cran-10000.html
# https://gist.github.com/daroczig/3cf06d6db4be2bbe3368
#
# The data is until Jan 2016 and is used directly for the analysis here
# But the gist also has the code to get the latest data if needed
#

pkgs = read.csv("https://gist.githubusercontent.com/daroczig/3cf06d6db4be2bbe3368/raw/8e970fad675d443813be2c98c508e6224491495e/results.csv", stringsAsFactors = FALSE)

# illustration of dygraphs package
# https://rstudio.github.io/dygraphs/index.html



# get an xts object from pkgs dataframe
pkgs$first_release_dt = as.Date(pkgs$first_release)
pkgs_xts = as.xts(pkgs$index, order.by = pkgs$first_release_dt)

# basic graph
dygraph(pkgs_xts)

# with range selector
dygraph(pkgs_xts) %>% dyRangeSelector()

# overlay events on timeline. Here key events from R timeline are used
# these are just sample key events in the timeline of R and not meant to be exhaustive
evnts = read.csv("explore_CRAN/data/Revents.csv", stringsAsFactors = FALSE)
evnts$dt = as.Date(evnts$evntDate)

# Dygraph plot of cran packages over time with R key events timeline overlayed on it
p = dygraph(pkgs_xts)
for(i in 1:nrow(evnts)){
  p = p %>% dyEvent(evnts$dt[i],evnts$event[i],labelLoc = "bottom")
}
p

# Plot of downloads from RStudio CRAN mirror
downlds = cran_downloads(from = "2012-10-01", to = "2017-01-31")
downlds_xts = as.xts(downlds$count, order.by = downlds$date)

dygraph(downlds_xts)

subpkg_dwnlds = cran_downloads(package = c("Rcpp","ggplot2","RColorBrewer"), 
                               from = "2014-01-01",to = "2017-01-31")
Rcpp_xts = as.xts(subpkg_dwnlds$count[subpkg_dwnlds$package == "Rcpp"], order.by = subpkg_dwnlds$date[subpkg_dwnlds$package == "Rcpp"])
ggplot2_xts = as.xts(subpkg_dwnlds$count[subpkg_dwnlds$package == "ggplot2"], order.by = subpkg_dwnlds$date[subpkg_dwnlds$package == "ggplot2"])
RColorBrewer_xts = as.xts(subpkg_dwnlds$count[subpkg_dwnlds$package == "RColorBrewer"], order.by = subpkg_dwnlds$date[subpkg_dwnlds$package == "RColorBrewer"])

subpkg_xts = cbind(Rcpp_xts, ggplot2_xts, RColorBrewer_xts)
names(subpkg_xts) = c("Rcpp","ggplot2","RColorBrewer")
dygraph(subpkg_xts) %>% dyHighlight(highlightSeriesOpts = list(strokeWidth = 3))

# Timeline of packages in rank 1-5 using timevis
top100 = cran_top_downloads("last-month", count = 100)
top100_dwnlds = cran_downloads(package = top100$package, from = "2014-10-01",to = "2017-01-31")
top100_dwnlds$wk = floor_date(top100_dwnlds$date, unit = "week")
top100_dwnlds_wk = top100_dwnlds %>% group_by(wk, package) %>% summarize(count = sum(count))
top100_dwnlds_wk = top100_dwnlds_wk %>% ungroup() %>% group_by(wk) %>% 
            mutate(rnk = dense_rank(desc(count))) %>% arrange(rnk)
top100_dwnlds_wk = top100_dwnlds_wk %>% filter(rnk <= 5) %>% arrange(rnk, wk)

package = top100_dwnlds_wk$package
lag_package = lag(package)
fresh = ifelse(lag_package != package,1,0)
fresh[1] = 0
top100_dwnlds_wk$fresh = fresh
top100_dwnlds_wk = top100_dwnlds_wk %>% group_by(rnk) %>% mutate(recnum = cumsum(fresh))
top100_dwnlds_wk2 = top100_dwnlds_wk %>% group_by(rnk, recnum, package) %>%
                    summarize(startdt = min(wk),enddt = max(wk)+6)



timeplt = data.frame(content = top100_dwnlds_wk2$package, 
                     start = top100_dwnlds_wk2$startdt,
                     end = top100_dwnlds_wk2$enddt,
                     group = top100_dwnlds_wk2$rnk
                     )
timeplt$id = 1:nrow(timeplt)

groups = data.frame(id = c(1,2,3,4,5), 
                    content = c("Rank 1", "Rank 2", "Rank 3", "Rank 4", "Rank 5"))

timevis(timeplt, groups = groups)

