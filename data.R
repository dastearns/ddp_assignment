require(data.table)
library(dplyr)
library(DT)
library(rCharts)

#minyr<-1880;
minyr<-2010;
maxyr<-2016;
yr_range <- c(minyr:maxyr);

src <- data.frame(
  name=factor(),
  sex=factor(),
  num=integer(),
  year=factor(),
  stringsAsFactors=FALSE
);

for (yr in yr_range) {
  file<-paste("data/yob", yr, ".txt", sep="");
  if (file.exists(file)) {
    file_src<-read.csv(file, header=FALSE);
    file_src$year = yr;
    colnames(file_src) <- c("name", "sex","num", "year");
    src<-rbind(src, file_src)
  } 
}


groupByName <- function(dt, minYear, maxYear,  name, exact) {
  name <- toupper(name)
  if (exact) {
    dt <- dt[toupper(dt$name)==toupper(name) & exact==1 & src$year >= minYear & src$year <= maxYear,]
  } else {
    dt <- dt[grepl(toupper(name), toupper(dt$name)) & exact==0 & src$year >= minYear & src$year <= maxYear,]
  }

  #result <- datatable(dt, options = list(iDisplayLength = 50))
  return(dt)
}

plotNamesCountByYear <- function(dt, dom = "NamesByYear", 
                                  xAxisLabel = "Year",
                                  yAxisLabel = "Number of Names") {
  NamesByYear <- nPlot(
    num ~ year,
    group = "sex",
    data = dt,
    type = "lineChart",
    dom = dom, 
    width = 650
  )
  
  NamesByYear$chart(margin = list(left = 50))
  NamesByYear$chart(color = c('pink', 'blue'))
  NamesByYear$yAxis(axisLabel = yAxisLabel, width = 80)
  NamesByYear$xAxis(axisLabel = xAxisLabel, width = 70)
  #NamesByYear$chart(tooltipContent = "#! function(key, x, y, e){ 
  #                   return '<h5><b>Year</b>: ' + e.point.year + '<br>' + '<b>Total Names</b>: ' + e.point.count + '<br>'
  #                   + '</h5>' } !#")
  NamesByYear
}