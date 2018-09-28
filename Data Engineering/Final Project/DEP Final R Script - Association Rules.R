library(arules)
library(readr)
#Santander <- read_csv("~/Desktop/Santander_cleaned_python.csv")

Sant.dat.pr <- data.frame(Santander[,15:38])

Sant.dat.pr <- na.omit(Sant.dat.pr)
Sant.dat.pr <- as.matrix(Sant.dat.pr)

rules1 <- apriori(Sant.dat.pr, parameter = list(supp = .007, conf = 0.8))

top.support <- sort(rules1, decreasing = TRUE, na.last = NA, by = "lift")
inspect(head(top.support, 20))

library(arulesViz)

plot(rules1, measure=c("support", "lift"), shading="confidence")
plot(rules1, type = "graph", by = "lift", jitter = 0)

n <- 100
subx1 <- head(sort(rules1, by="lift"), n)
plot(subx1, method= "grouped",control=list(k=n))

subx <- head(sort(rules1, by="lift"), 10)
plot(subx, method="graph", control=list(type="items"))
