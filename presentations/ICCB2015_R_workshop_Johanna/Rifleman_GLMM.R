
install.packages("lme4")

library("lme4") ## The lmer() function of this package creates the GLMM for us.


Rif_data <- read.csv("D:/Bibliotheken/Documents/ICCB2015_R_workshop_Johanna/Rifleman_data.csv")

Rif_data


Rif.model <- lmer(rif_presence ~ area + connectivity + (1|patch_id), data=Rif_data) # does not work...

Rif.model <- lmer(rif_presence ~ area + connectivity + (1|patch_id),family=binomial, data=Rif_data) #ARRRR....


?? glmer
Rif.model <- glmer(rif_presence ~ area + connectivity + (1|patch_id),family=binomial, data=Rif_data)
summary(Rif.model)

plot(fitted(Rif.model),residuals(Rif.model))







