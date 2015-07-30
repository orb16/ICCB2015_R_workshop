##################### R Workshop: Graphing with ggplot2 #######################
                            ## Jennifer Bufford ##
                      ## jennifer.bufford@lincoln.ac.nz ##
                             # December 15, 2014 #

###############################################################################

#Input: iris

#Requires: ggplot2, plyr

#Output: Iris Graphs.pdf
#        ggplot Graphs.RData

#This script will run through examples of the following aspects of graping in ggplot:
#   simple plots
#   changing colour, shape, linetype, scales, etc.
#   adding regression lines and smoothers
#   spliting plots by groups using "facet"
#   bar plot with error bars
#   using theme() and base plots

#The script also looks at some alternate ways to calculate means and standard errors
#   and uses merge()

###############################################################################


#setwd("R Stats/R Workshop")

data(iris)


## Load Required Packages ##

#Note, you may have to install one or more of these packages, first
library(ggplot2)
library(plyr)


# pdf(file="Iris Graphs.pdf", width=16, height=8)



##### Background about ggplot #################################################


# ggplot2 (package by Hadley Wickham)
# 
# Advantages:
#   Easy to make nice plots
#   Easy to plot colours/shapes, legends, error bars
# 
# Challenges:
#   Very different grammar than plot()
#   Often need specific data formatting in order to plot
#   Some (intentional) limits



##### Grammar of Graphics #####################################################


# ggplot uses the "grammar of graphics", which is quite different from plot()
# Here are some basics to get you started:

# Plot in layers
#     ggplot() sets up overall plot
#     Use + to add new layers (e.g. points, scales, etc.)
# Aesthetics (mapping) = data
#     aes(x=, y=)
# Geometries = plots the data 
#     geom_something() (e.g. bars, lines, points)
# Scales = configures the layers
#     scale_something() 
# Themes = overall appearance
#     theme()



##### Help for ggplot #########################################################


#http://www.cookbook-r.com/Graphs/
#http://docs.ggplot2.org/current/
#http://ramnathv.github.io/pycon2014-r/visualize/ggplot2.html



##### Examples and Exercises ##################################################


## Below are some exercises, some of which are done as examples and some which
##    ask you to make a plot yourself.  
##  Answers to the exercises are in Graphing w ggplot2 Answers.R



##### Format Data #############################################################


str(iris)

iris$Loc <- factor(rep(c('ChicChocs',"LawrenceRiver",'ChaleurBay'), 50))
iris$Habitat <- factor(sample(c('meadow','marsh','riparian'), 150, replace=T))




##### Simple Plots ############################################################


## Scatterplot ##

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width)) + geom_point()


## Boxplot ##

ggplot(data=iris, aes(x=Species, y=Petal.Width)) + geom_boxplot()


## Histogram ##

ggplot(data=iris, aes(x=Sepal.Length)) + geom_histogram()


## Bar Plot ##

#generate data
bar.dat <- data.frame("Ht"=rpois(4, 5), 'Species'=c('A','B','C','D'))

ggplot(data=bar.dat, aes(x=Species, y=Ht)) + geom_bar(stat="identity")


## Line Plot ##

#generate data
line.dat <- data.frame('Days'=1:7, 'Productivity'=rnorm(7,50,10))

ggplot(data=line.dat, aes(x=Days, y=Productivity)) + geom_line()


## Exercise: Line and Point Plot ##
#Use line.dat for your plot





##### Changing Shape, Colour ##################################################


## Change Colour ##

#all points one colour
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width)) + geom_point(colour="blue")

#points are coloured by species
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) + geom_point()

#the difference between colour and fill
ggplot(data=bar.dat, aes(x=Species, y=Ht, colour=Species)) + geom_bar(stat='identity')
ggplot(data=bar.dat, aes(x=Species, y=Ht, fill=Species)) + geom_bar(stat='identity')


## Change Shape Type ##

#points all have the same shape
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width)) + geom_point(shape=2)

#points are shaped by Species
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, shape=Species)) + geom_point()


## Change Line Type ##

#points all have the same shape
ggplot(data=line.dat, aes(x=Days, y=Productivity)) + geom_line(lty=2, size=3)


## Change Size ##

#points all have the same size
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width)) + geom_point(size=6)

#points are sized by Species
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, size=Species)) + geom_point()


## Exercise: Change Colour, Shape & Size ##
#Set a colour by species, shape by habitat and size by location





##### Modifying Scales ########################################################


## Modify scale labels ##

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) + ylab('Sepal Width (cm)') + xlab('Petal Length (cm)')


## Modify X-Y Scales ##

#Set min and max
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) +
  scale_x_continuous(name="Petal Length (cm)", limits=c(3,7))

#Set tick labels
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) +
  scale_x_continuous(name="Petal Length (cm)", breaks=seq(1,7, by=1))

#Set axis using expand
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) +
  scale_y_continuous(name="Sepal Width (cm)", expand=c(0,0.1))


## Set Colour Scale ##

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) + scale_colour_manual(values=c('darkgreen','firebrick','skyblue'))

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) +
  scale_colour_manual(name="Sp", values=c('firebrick','darkgreen','skyblue'),
                     labels=c('Iris setosa','Iris versicolor','Iris virginica'))


## Using Colour Schemes ##

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) + scale_colour_brewer()

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) + scale_colour_brewer(type='div')

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) + scale_colour_brewer(type='qual')

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6) + scale_colour_brewer(type='qual',palette=2)

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=6)


## Exercise: Set Shape Scale ##

#Set the Shape so that setosa is a solid circle, versicolor an open square,
#   and virginica a +
#Set the labels to "I. " and then the species name and make the legend title blank
#use scale_shape_manual (also check pch), look in R help or ggplot2 website for help





##### Adding Regression Lines #################################################


## Linear Regression ##

#All points, irrespective of species (e.g. Sepal.Length ~ Petal.Length)
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length)) + geom_point(size=6) +
  geom_smooth(method="lm")

#Modify the line, without 95% CI Shading
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length)) + geom_point(size=6) +
  geom_smooth(method="lm", size=3, se=F, colour="red")

#By Species (e.g. Sepal.Length ~ Petal.Length*Species)
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length, colour=Species)) +
  geom_point(size=6) + geom_smooth(method="lm")


## Smoothers ##

#All points together
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length)) + geom_point(size=6) +
  geom_smooth()

#By Species
ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length, colour=Species)) +
  geom_point(size=6) + geom_smooth()


## Exercise: Plot Petal.Width vs Sepal.Width with linear regression by Sp ##







##### Facets ##################################################################


ggplot(data=iris, aes(x=Sepal.Width)) + stat_bin(breaks=c(2,3.1,4.2)) +
  facet_grid(~Species)


## Facet ##

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length, colour=Species)) +
  geom_point(size=6) + facet_grid(~Loc)

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length, colour=Species)) +
  geom_point(size=6) + facet_grid(Loc~Habitat)

ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length, colour=Species)) +
  geom_point(size=6) + facet_grid(~Loc + Habitat)


## Exercise: Plot with Location in Colours and Facet by Species ##





##### Formatting Data for ggplot ##############################################


spdat <- ddply(.data = iris, .variables = c('Species','Habitat'), .fun=function(x){
  y <- data.frame('PL.m' = mean(x$Petal.Length),
                  'PL.se' = sd(x$Petal.Length)/sqrt(nrow(x)))
  return(y)
})


## Exercise: Find Mean and SE for Sepal.Length by Species and Habitat ##
#call your new data.frame spdat2, call your columns SL.m and SL.se






## Merge Data ##

(sp.dat <- merge(spdat, spdat2))



##### Adding Error Bars #######################################################


## Basic Bar Plot ##

ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge")


## Add Error Bars ##

ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") +
  geom_errorbar(aes(ymin = PL.m-PL.se, ymax=PL.m+PL.se), position="dodge")

ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") +
  geom_errorbar(aes(ymin = PL.m-PL.se, ymax=PL.m+PL.se), width=0.5,
                position=position_dodge(width=0.9))


## Advanced: Vertical and Horizontal Error Bars ##

ggplot(sp.dat, aes(x=SL.m, y=PL.m, colour=Species, shape=Habitat)) +
  geom_point(size=4) +
  geom_errorbar(aes(ymin = PL.m-PL.se, ymax=PL.m+PL.se)) +
  geom_errorbarh(aes(xmin = SL.m-SL.se, xmax=SL.m+SL.se))


## Exercise: Create a Bar Plot with Error Bars for Sepal Length ##
#Add informative axis labels





##### Using Theme #############################################################


## Pre-set Themes ##

#Black and white
ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") + theme_bw()

#Classic
ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") + theme_classic()

#Minimal
ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") + theme_minimal()


## Grid Lines ##

ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") +
  theme(panel.grid = element_blank())


## Legend Position ##

ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") +
  theme(legend.position = c(0.1,0.85))


## Modify Facets ##

ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") + facet_grid(~Habitat) +
  theme(strip.background = element_rect(fill='purple'))


## Modifying Text ##

ggplot(sp.dat, aes(x=Species, y=PL.m, fill=Habitat)) +
  geom_bar(stat='identity', position="dodge") +
  theme(axis.text = element_text(size=14), axis.title = element_text(size = 20),
        legend.text = element_text(size=12, colour="red"),
        legend.title=element_text(size=20))


## Exercise: Create a plot with a white background, no grid lines, and all text >=12
#Add informative axis labels





##### Using a Base Plot #######################################################


## Create Base Plot ##

base.plot <- ggplot(data=iris, aes(x=Petal.Length, y=Sepal.Length, colour=Species)) +
  scale_colour_manual(values=c('firebrick','darkgreen','skyblue'),
                     labels=c('Iris setosa','Iris versicolor','Iris virginica')) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text = element_text(size = 16), axis.title = element_text(size = 18),
        legend.text = element_text(size=16), legend.key = element_rect(colour="white"),
        legend.title = element_blank(), strip.text = element_text(size=18),
        strip.background = element_rect(fill="white"))


## Plot ##

base.plot + geom_point() + xlab('Petal Length (cm)')

base.plot + geom_point(aes(x=Sepal.Length, y=Petal.Length))

base.plot + geom_bar(data=sp.dat, aes(x=Species, y=PL.m, fill=Habitat), stat='identity',
                     position="dodge")


## Exercise: Create a base plot for the bar graph (sp.dat), then add bars and errorbars





##### Additional Packages #####################################################


#the package 'GGally' includes the function ggpairs, which allows you to
#   quickly make pairwise plots in ggplot

#the package 'ggthemes' extends many of the theme() elements in ggplot, including
#   different pre-set themes, and pre-set colour schemes
#   (e.g. scale_colour_colorblind - note the spelling)

#ggsave() is a useful way to save your plots (like pdf())



##### Save Plots, Data ########################################################


# dev.off()


## Save Workspace ##

save.image(file="ggplot Graphing.RData")


