# based on timeline from http://fishyoperations.com/r/timeline-graph-with-ggplot2/, via R-bloggers
# might need to fix right margin

setwd("~/Dropbox/R/R-timeline")
library(ggplot2)
#library(sfsmisc) # for p.arrows()

# import a text file with "year" and "text" columns and modify from there
path <- "./timeset.csv"
timeset <- read.csv(path)
appel <- "Milestones in R"

## alternatively, you can create dataset in R like so:
#appel <- "A Schumwinger Decade"
#timeset<-data.frame(year=c(2003,2004,2006,2006.5,2008,2009,2009.5,2010,2011,2013),text=c(
 # "Trinidad wedding",
  #"725 E.Townsend St.",
  #"Leo's birth",
  #"begin 50/50 split",
  #"Silas' birth",
  #"joined Lake Park",
  #"2438 N. Humboldt Blvd.",
  #"Quinton's birth",
  #"begining of \nCommunity Night",
  #"10 year celebration!"))

# add random y values
records <- dim(timeset)[1] # number of records for timeset
timeset$y[seq(2, records, 2)] <- runif(trunc(records/2),.5,1.5) # alternate y above 
timeset$y[seq(1, records, 2)] <- runif(records-trunc(records/2),-1.5,-.5) # and below zero

# create and position lables
timeset$ytext<-timeset$y
timeset[timeset$y<0,]$ytext<-timeset[timeset$y<0,]$y-.7
timeset$labelDate <- trunc(timeset$year) #creates a date lable truncated to year

## time to plot
plot<-ggplot(timeset,aes(x=year,y=0))
plot<-plot+geom_segment(aes(y=0,yend=y,xend=year))
plot<-plot+geom_text(aes(y=ytext,label=paste(text, "\n", labelDate, sep=" ")),size=2.5,vjust=-.5)# add dates here
plot<-plot+geom_point(aes(y=y))
plot<-plot+scale_y_continuous(limits=c(-2.5,2))
#draw a horizontal line
plot<-plot+geom_hline(y=0,size=1.5,color='orange') 
# this adds an arrow just to the right of last event
plot<-plot+geom_segment(x=timeset$year[records] + 0.2, xend=timeset$year[records] + 0.89, y=.1, yend=0,color='orange',size=1.5)+
  geom_segment(x= timeset$year[records] + 0.2, xend=timeset$year[records] + 0.89, y=-.1, yend=0,color='orange',size=1.5) 

## test p.arrows()
#p.arrows(x1, y1, x2, y2, size = 1, width, fill = "dark blue", ...)
#plot<-plot+p.arrows(2000,.1, 2002, 0)

plot<-plot+opts(axis.text.y =theme_blank(), # remove axes, ticks, and grid
                title= appel, 
                panel.background = theme_blank(),
                panel.grid.major = theme_blank(),
                panel.grid.minor = theme_blank(),
                panel.border = theme_blank(),
                axis.ticks = theme_blank(),
                axis.text.x = theme_blank()
                )

plot<-plot+ylab('')+xlab('')
plot <- plot
print(plot)

#ggsave('timeline_plot.png')

### Issues/ideas
# use real dates. lubridate?
# fix demension and margins
# how do handle lable overlap
# change colors to blue and white, open circle marks
# ? widen horizontal line and place year labels within it?
# use p.arrows? 