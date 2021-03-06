# 연속변수가 아니라면 Kruskal-wallis H Test
# 정규분포가 아니라면 Kruskal-wallis H Test
# 등분산이 아니라면 welch's anova
# ANOVA 사용(다 통과되면)
# 사후검정 : Tukey
install.packages("rlang")
install.packages("stringi")
library(rlang)
library(moonBook)

View(acs)

# 판정 집단 3개에 따라서 콜레스트롤5gs 수치가 어떻게 달라지는지 확인해 보자
# 종속변수(결과변수) : LDLC (저밀도 콜레스트롤 수치)
# 독립변수(원인변수) : Dx (진단 결과) : STEMI	, NSTEMI, Unstable Angina

moonBook::densityplot(LDLC~Dx,data=acs)

shapiro.test(acs$LDLC[acs$Dx=="NSTEMI"])#정규 분포 x
shapiro.test(acs$LDLC[acs$Dx=="STEMI"]) #정규 분포 o
shapiro.test(acs$LDLC[acs$Dx=="Unstable Angina"]) #정규 분포 x

#정규 분포를 확인을 위한 또 다른 방법
out <- aov(LDLC~Dx,data = acs)
out
shapiro.test(resid(out))

#등분산 확인
bartlett.test(LDLC~Dx,acs)

# 정규분포이고 등분산이라면 : aov()
out <- aov(LDLC~Dx,data = acs)
summary(out)

# 연속변수가 아니거나 정규분포가 아니라면 : kruskal,test()
kruskal.test(LDLC~Dx,acs)

# 등분산이 아니라면 : oneway.test()
oneway.test(LDLC~Dx,acs,var.equal = F)

### 사후검정
# aov()를 사용했을 떄 사후검정 : TukeyHSD()
TukeyHSD(out)

#kruscal.test( )을 사용했을때 사후검정
str(InsectSprays)
View(InsectSprays)

moonBook::densityplot(count~spray,data = InsectSprays)

install.packages("userfriendlyscience")

library(userfriendlyscience)
posthocTGH(x=InsectSprays$spray,y=InsectSprays$count, method = "games-howell")

#oneway.test()를 사용했을 때 사후검정
install.packages("nparcomp")
library(nparcomp)
result <- mctp(LDLC~Dx,acs)

summary(result)               

########################################################################################################

head(iris)

#풍좀별로 Sepal.Length,Width의 평균 차이가 있는지 없는가 확인하라

moonBook::densityplot(Sepal.Length~Species,data=iris)
moonBook::densityplot(Sepal.Width~Species,data=iris)

out <- aov(Sepal.Width~Species,data=iris) 
shapiro.test(resid(out)) # 정규분포 o
#summary(out)

#등분산인가?
bartlett.test(Sepal.Width~Species,data=iris) #등분산 o


summary(out) # p-value = 1.569e-14 차이가 있다

TukeyHSD(out)

##########################################################################################################

# 시 군 구에 따라서 합계 출산율의 차이가 있는가? 있다면 어느것과 차이가 있는가?

mydata<-read.csv("data/anova_one_way.csv")
head(mydata)

moonBook::densityplot(birth_rate~ad_layer,data=mydata)

out<- aov(birth_rate~ad_layer,mydata)
shapiro.test(resid(out)) #정규 분포가 아니다.

kruskal.test(birth_rate~ad_layer,mydata) # 차이가 있다 p-value < 2.2e-16

with(mydata,posthocTGH(x=ad_layer, y=birth_rate,method = "games-howell"))

##############################################################################################################

### Two-way-ANOVA
# multichild : 다가구 지원조례 채택 여부
mydata <- read.csv("data/anova_two_way.csv")
head(mydata)

# 정규 분포 확인
out<-aov(birth_rate~ad_layer+multichild+ad_layer:multichild,data=mydata)
shapiro.test(resid(out)) # X

summary(out)

TukeyHSD(out)

#############################################################################################################

# 연속변수나 정규분포가 아닐 경우
# one way repeated measures anova : friedman.test()

?friedman.test

RoundingTimes <-
  matrix(c(5.40, 5.50, 5.55,
           5.85, 5.70, 5.75,
           5.20, 5.60, 5.50,
           5.55, 5.50, 5.40,
           5.90, 5.85, 5.70,
           5.45, 5.55, 5.60,
           5.40, 5.40, 5.35,
           5.45, 5.50, 5.35,
           5.25, 5.15, 5.00,
           5.85, 5.80, 5.70,
           5.25, 5.20, 5.10,
           5.65, 5.55, 5.45,
           5.60, 5.35, 5.45,
           5.05, 5.00, 4.95,
           5.50, 5.50, 5.40,
           5.45, 5.55, 5.50,
           5.55, 5.55, 5.35,
           5.45, 5.50, 5.55,
           5.50, 5.45, 5.25,
           5.65, 5.60, 5.40,
           5.70, 5.65, 5.55,
           6.30, 6.30, 6.25),
         nrow = 22,
         byrow = TRUE,
         dimnames = list(1 : 22,
                         c("Round Out", "Narrow Angle", "Wide Angle")))
head(RoundingTimes)

#정규분포

library(reshape)

rt1<-reshape::melt(RoundingTimes)
rt1

out <- aov(value~X2,rt1)
shapiro.test(resid(out))

boxplot(value~X2,data=rt1)

friedman.test(RoundingTimes)

# 사후 검정
source("friedmen_hoc.R")

friedman.test.with.post.hoc(value~X2 | X1,rt1)

# 본페로니 검정
0.05/3

#############################################################################################################
###Two way Repeadted mesures anova
#여드름 치료 테스트 데이터
mydata <- read.csv("data/10_rmanova.csv")
head(mydata)

#long형으로 구조 변경
ac1<-reshape(mydata,direction = "long",varying =3:6,sep="")
ac1

ac2 <-reshape::melt(mydata,id=c("group","id"),variable.names ="time",
                    value.name="month",
                    measure.vars=c("month0","month1","month3","month6"))
ac2

# 시각화
?interaction.plot()
str(ac1)

ac1$group <- factor(ac1$group)
ac1$id <- factor(ac1$id)
ac1$time <- factor(ac1$time)

interaction.plot(ac1$time,ac1$group,ac1$month)

out <- aov(month~group*time+Error(id),ac1) #서로 다른 관점에서 조합
summary(out) # 두 그룹이 전부 시간적 차이에 따른 변화가 있다.

# 사후 검증
 ac_0 <- ac1[ac1$time=="0",]
 ac_1 <- ac1[ac1$time=="1",]
 ac_3 <- ac1[ac1$time=="3",]
 ac_6 <- ac1[ac1$time=="6",]

 t.test(month~group,ac_0)
 t.test(month~group,ac_1)
 t.test(month~group,ac_3)
 t.test(month~group,ac_6)
 
 #0.05/6 (4C2) 0.008  
 #nCr 계산법 n!/(n-r)!*r! ex) 4*3*2*1/2! * 2! = 24/4 = 6
 