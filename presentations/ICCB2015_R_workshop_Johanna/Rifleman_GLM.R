library("ggplot2")
library("coefplot")



tomtit_data <- read.csv("D:/Bibliotheken/Documents/ICCB2015_R_workshop_Johanna/Tomtit_data.csv")

tomtit_data
# summary(Rif_data)

tomtit.model <- lm(tomtit_abundance ~ habitat_type, tomtit_data)
# tomtit.model2 <- lm (tomtit_abundance ~ habitat_type, family=poisson, tomtit_data)

summary(tomtit.model)


coefplot(tomtit.model)

plot(fitted(tomtit.model),residuals(tomtit.model))

hist(residuals(tomtit.model))


