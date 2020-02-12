# Power Analysis : 적당한 표본의 갯수 산출
install.packages("pwr")

library(pwr)

ky <- read.csv("data/KY.csv",header = T)
head(ky)

table(ky$group)

mean_1 <- mean(ky$score[ky$group==1])
mean_2 <- mean(ky$score[ky$group==2])
cat(mean_1,mean_2)

sd_1 <- sd(ky$score[ky$group==1])
sd_2 <- sd(ky$score[ky$group==2])

effsize<-abs(mean_1-mean_2)/sqrt((sd_1^2+sd_2^2)/2)
effsize

#alternative 양쪽 한쪽 보는거 지정 / 표본 갯수 산출 n
pwr.t.test(d=effsize, type="two.sample",alternative = "two.sided",power = 0.8,sig.level = 0.05) 

