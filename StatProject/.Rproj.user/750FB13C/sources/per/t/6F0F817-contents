install.packages("UsingR")
library(UsingR)

str(galton)
View(galton)

plot(child~parent,galton)

cor.test(galton$child,galton$parent)

out <- lm(child~parent,galton)
summary(out)

abline(out,col="blue")

plot(jitter(child,5)~jitter(parent,5),data = galton)

sunflowerplot(galton)

##########################################################################################################
# pop_growth : 인구 증가률, elderly_late : 고령인구 비율, finance : 제정 자립도
# cultural_center : 인구 10만명당 문화 기반 시설수
mydata <- read.csv("data/cor.csv")
head(mydata)
str(mydata)

plot(mydata$pop_growth~mydata$elderly_rate)

cor(mydata$pop_growth,mydata$elderly_rate, method = "pearson")
cor(mydata$pop_growth,mydata$elderly_rate, method = "spearman")

# 많은 변수에 대해서 상관분석을 해야한다면
s <-  with(mydata,cbind(pop_growth,birth_rate,elderly_rate,finance,cultural_center))
cor(s)
