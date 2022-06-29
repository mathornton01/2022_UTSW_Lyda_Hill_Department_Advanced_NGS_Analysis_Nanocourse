abundances <- round(c(runif(30,300,350),runif(30,325,400)));
tumorpresent <- c(rep(0,30),rep(1,30))
age <- runif(60,30,60);
effectsize <- 5;
data.frame(cbind(abundances,tumorpresent,age)) -> exdf;
exdf$abundances <- exdf$abundances- effectsize*exdf$age;
form1 <- formula(abundances~tumorpresent*age);
glm1 <- glm(form1,family=poisson(link='identity'),data=exdf);
summary(glm1);