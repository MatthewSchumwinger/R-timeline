# based on timeline from http://fishyoperations.com/r/timeline-graph-with-ggplot2/, via R-bloggers
# might need to fix right margin

setwd("~/Dropbox/R/R-timeline")
library(ggplot2)

timeset<-data.frame(year=c(2003,2004,2006,2006.5,2008,2009,2009.5,2010,2011,2013),text=c(
  "Trinidad wedding",
  "725 E.Townsend St.",
  "Leo's birth",
  "begin 50/50 split",
  "Silas' birth",
  "joined Lake Park",
  "2438 N. Humboldt Blvd.",
  "Quinton's birth",
  "begining of \nCommunity Night",
  "10 year celebration!"),                  
                    y=c(runif(5,.5,1.5),runif(5,-1.5,-.5)))

## alternatively, you can import a text file with "year" and "text" columns and modify from there
path <- "./timeset.csv"
timeset2 <- read.csv(path)

n <- dim(timeset)[1] 
timeset$y[seq(1, n, 2)] <- runif(5,.5,1.5)
timeset$y[seq(2, n, 2)] <- runif(5,-1.5,-.5)

timeset$ytext<-timeset$y
timeset[timeset$y<0,]$ytext<-timeset[timeset$y<0,]$y-.7

timeset$labelDate <- round(timeset$year, digits = 0) 

plot<-ggplot(timeset,aes(x=year,y=0))
plot<-plot+geom_segment(aes(y=0,yend=y,xend=year))
plot<-plot+geom_text(aes(y=ytext,label=paste(text, "\n", labelDate, sep=" ")),size=2.5,vjust=-.5)# add dates here
plot<-plot+geom_point(aes(y=y))
plot<-plot+scale_y_continuous(limits=c(-2.5,2))
plot<-plot+geom_hline(y=0,size=1.5,color='orange')   #draw a horizontal line
# this adds arrow, kinda ugly
plot<-plot+geom_segment(x=2013.2,xend=2013.49,y=.1,yend=0,color='orange',size=1.5)+
  geom_segment(x=2013.2,xend=2013.49,y=-.1,yend=0,color='orange',size=1.5) #drawing the actual arrow

plot<-plot+opts(axis.text.y =theme_blank(),
                title='A Schumwinger Decade', 
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