
install.packages("lme4")

library("lme4") ## The lmer() function of this package creates the GLMM for us.


Rif_data <- read.csv("ICCB2015_R_workshop_Johanna/Rilfeman_data.csv")

Rif_data

Rif.model1 <- glm(rif_presence ~ area + connectivity,family=binomial, data=Rif_data)

Rif.model2 <- glmer(rif_presence ~ area + connectivity + (1|patch_id),family=binomial, data=Rif_data)

summary(Rif.model1)
summary(Rif.model2)

coefplot2(list(Rif.model1, Rif.model2)) # glm model is the black dots, glmer is the red









