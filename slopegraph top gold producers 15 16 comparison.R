### WORKS! based on slopegraph http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Slope%20Chart
### not very pretty


library(ggplot2)
library(scales)
theme_set(theme_classic())

library(readr)
goldprod <- read_csv("~/cvcv.csv")



colnames(goldprod) <- c("property", "2015", "2016")
left_label <- paste(goldprod$property, round(goldprod$`2015`),sep=", ")
right_label <- paste(goldprod$property, round(goldprod$`2016`),sep=", ")
goldprod$class <- ifelse((goldprod$`2015` - goldprod$`2016`) < 0, "red", "green")

# Plot
p <- ggplot(goldprod) + geom_segment(aes(x=1, xend=2, y=`2015`, yend=`2016`, col=class), size=.75, show.legend=F) +
  geom_vline(xintercept=1, linetype="dashed", size=.1) +
  geom_vline(xintercept=2, linetype="dashed", size=.1) +
  scale_color_manual(labels = c("Up", "Down"), values = c("green"="#00ba38", "red"="#f8766d")) +  # color of lines 
  labs(x="", y="Mean GdpPerCap") +  # Axis labels
  xlim(.5, 2.5) + ylim(400,(1.1*(max(goldprod$`2015`, goldprod$`2016`))))  # X and Y axis limits

# Add texts
p <- p + geom_text(label=left_label, y=goldprod$`2015`, x=rep(1, NROW(goldprod)), hjust=1.1, size=3.5)
p <- p + geom_text(label=right_label, y=goldprod$`2016`, x=rep(2, NROW(goldprod)), hjust=-0.1, size=3.5)
p <- p + geom_text(label="2016", x=1, y=1.1*(max(goldprod$`2015`, goldprod$`2016`)), hjust=1.2, size=5)  # title
p <- p + geom_text(label="2015", x=2, y=1.1*(max(goldprod$`2015`, goldprod$`2016`)), hjust=-0.1, size=5)  # title

# Minify theme
p + theme(panel.background = element_blank(), panel.grid = element_blank(), axis.ticks = element_blank(), axis.text.x = element_blank(), panel.border = element_blank(), plot.margin = unit(c(1,2,1,2), "cm"))