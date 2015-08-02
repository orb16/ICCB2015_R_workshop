library("ggplot2")
library("coefplot")



tomtit_data <- read.csv("ICCB2015_R_workshop_Johanna/Tomtit_data.csv")

tomtit_data
# summary(Rif_data)

tomtit.model <- glm(tomtit_abundance ~ habitat_type, tomtit_data, family = "poisson")
# tomtit.model2 <- lm (tomtit_abundance ~ habitat_type, family=poisson, tomtit_data)

summary(tomtit.model)


coefplot2(tomtit.model, intercept = TRUE)


hist(residuals(tomtit.model))


