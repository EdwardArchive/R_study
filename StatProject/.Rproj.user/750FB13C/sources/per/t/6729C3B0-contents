######## 두 그룹의 평균 비교
#------------------------------

# T-Test, student T-Test, 일반적인 T-test라고 한다면 독립표본이다(Independent)  / 모수적인 방식
# Mann-whitney u-test(wilcoxen rank-sum test, Mann-whitney -wilcoxen test(MWW)) / 비 모수적인 방식
# wlech's T-Test

# 결과값이 연속 변수인지 아닌지
# 결과값이 연속변수면       : T-Test
# 결과값이 연속변수가아니면 : Mann-whitney u-test

# 정규 분포 여부
# TRUE  : T-Test
# FALSE : Mann-whitney u-test

#등분산 여부
# TRUE : T-test
# FALSE : welch's T-Test

#위의 세가지 경우를 모두 통과해야 T-Test를 사용할 수 있다.

install.packages("moonBook")
library(moonBook)

# 경기도에 소재한 한 대학병원에서 2년동안 내원한 관상동맥증후군 환자
?acs
head(acs)
str(acs)

mean.man <- mean(acs$age[acs$sex=="Male"])
mean.woman <- mean(acs$age[acs$sex=="Female"])
cat(mean.man,mean.woman)

# 나이는 연속값 통과 / 그래프로 정규분포 확인
moonBook::densityplot(age ~ #결과 변수
                        sex,data=acs)#원인 변수

# 정규 분포 테스트(Shapiro Test/ Shaprio Wilk Test)
# 귀무가설 : 정규 분포가 맞다 
# 대립가설 : 정규 분포가 아니다

shapiro.test(acs$age[acs$sex=="Male"])
# W = 0.99631, p-value = 0.2098 p>0.05 => 정규 분포가 맞다

shapiro.test(acs$age[acs$sex=="Female"])
# W = 0.96138, p-value = 6.34e-07 p<0.05=> 정규 분포가 아니다

#등분산 테스트
# 귀무가설 : 등분산이 맞다 
# 대립가설 : 등분산이 아니다

var.test(age ~ sex,acs)
#F = 0.91353, num df = 286, denom df = 569, p-value = 0.3866 p>0.05 => 등분산이 맞다

#wilcox test
#귀무가설 :남성과 여셩의 평균나이가 차이가 없다
# 대립가설 : 남성과 여성의 평균나이가 차이가 있다

wilcox.test(age ~ sex, data = acs )
#W = 115271, p-value < 2.2e-16 p<0.05 남성과 여성의 평균나이가 차이가 있다.

#만약 평균 분포였다면
t.test(age ~ sex,data = acs,var.test=T) # 등분산일 경우
t.test(age ~ sex,data = acs,var.test=F) # 등분산이 아니다 (welch's test)

############################################################################################################

### 1개의 집단인 경우
# A회사의 건전지 수명이 1000시간일때 무작위로 뽑은 10개의 건전지 수명에 대해 샘플이
# 모집단과 다르다고 할수 있는가?
# 귀무가설 : 모집단의 평균과 같다, 대립가설 : 모집단의 평균과 다르다

a <- c(980,1008,968,1032,1012,1002,996,1017,990,955)
a_mean <- mean(a)
a_mean

shapiro.test(a)
# W = 0.98274, p-value = 0.9781 p>0.05 정규분포다 (매우)
var.test(a,1000)
#t.test
t.test(a,mu=1000)
# p-value = 0.602 p>0.05 1000 시간이라고 볼수 있다
?t.test()
?var.test

#############################################################################################################

#어떤 학급의 수학 평균성적이 55점이였다. 0교시 수업을 시행학 나서 학생들의 성적을 살펴보았다.
a <- c(58,49,39,99,32,88,62,30,55,65,44,55,57,53,88,42,39)

shapiro.test(a)
# W = 0.91143, p-value = 0.1058 / 정규 분포가 맞다

t.test(a,mu=55,alternative = "greater") 
# t = 0.24546, df = 16, p-value = 0.8092 차이가 거의 없다
# alternative = "greater" t = 0.24546, df = 16, p-value = 0.4046

##############################################################################################################

# 20개 도시 추출(우리나라 76개의 자치도시 중에 20개만 추출)
# 귀무 가설 : 20개 도시의 합계 출산율이 모집단의 합계 출산율과 같다.
# 대립 가설 : 20개 도시의 합계 출산율이 모집다의 합계 출산율과 다르다.
# 모집단의 평균 출산율은 1.37812

mydata <- read.csv("data/onesample.csv")
mydata

mean_data <- mean(mydata$birth_rate)
mean_data

shapiro.test(mydata$birth_rate)
#W = 0.92991, p-value = 0.1538 정규 분포 정규 분포이다

t.test(mydata$birth_rate,mu=1.37812)
#t = -4.6387, df = 19, p-value = 0.0001791 p<0.05 도시별로 합계 출산율이 다르다

##############################################################################################################

# dummy라는 컬럼은 0은 군을 나타내고 1은 시를 나태내는 컬럼이다.
# 시와 군에 따라 합계 출산율의 차이가 있는지 없는지를 보려고 한다.
# 귀무가설 : 차이가 없다.
# 대립가설 : 차이가 있다.

str(mydata)
mydata <- read.csv("data/independent.csv")
mydata

moonBook::densityplot(birth_rate ~ #결과 변수
                        dummy,data=mydata)#원인 변수

shapiro.test(mydata$birth_rate[mydata$dummy==0]) # 정규분포 x 0.05
shapiro.test(mydata$birth_rate[mydata$dummy==1]) # 정규분포 x

wilcox.test(birth_rate ~ dummy,mydata) # p-value = 0.04152 차이는 있다.

##############################################################################################################

# 오토나 수동에 따라 연비가 같을까? 다를까
# am => 0 Auto 1은 수동
str(mtcars)
head(mtcars)

densityplot(mpg~am,mtcars)

shapiro.test(mtcars$mpg[mtcars$am==0]) # W = 0.97677, p-value = 0.8987 / 정규분포 o
shapiro.test(mtcars$mpg[mtcars$am==1]) # W = 0.9458, p-value = 0.5363 / 정규분포 o

var.test(mpg~am,data = mtcars) # p-value = 0.06691 등분산이 맞다

t.test(mpg~am,data = mtcars,var.test=T) # p-value = 0.001374 차이가 난다. 연비와 / am은 관계가 있다.

##############################################################################################################

pd <- read.csv("data/pairedData.csv")
pd

# 데이터를 long형으로 구조변경 (melt, cast(decast))
library(reshape2)
pd<-melt(pd,id =("ID"),variable.name = "GROUP",value.name = "RESULT")

shapiro.test(pd$RESULT[pd$GROUP=="before"]) #정규분포 o
shapiro.test(pd$RESULT[pd$GROUP=="After"])  #정규분포 o

t.test(RESULT~GROUP,data = pd, paired=T) #차이가 있다.

before <- subset(pd,GROUP=="before",RESULT)
before
after <- subset(pd,GROUP=="After",RESULT)
after

install.packages("PairedData")
library(PairedData)

pd3 <- paired(before,after)
plot(pd3,type = "profile")
#############################################################################################################

str(sleep)
View(sleep)

group_1 <- subset(sleep,group==1,extra)
group_2 <- subset(sleep,group==2,extra)

sleep2 <- paired(group_1,group_2)
plot(sleep2,type="profile")

shapiro.test(sleep$extra[sleep$group==1]) # 정규분포 o
shapiro.test(sleep$extra[sleep$group==2]) # 정규분포 o

var.test(extra ~ group,data = sleep) #등분산 o

t.test(extra ~ group,data = sleep ,paired=T) # 차이가 난다

# 정규 분포가 아니라면

with(sleep,wilcox.test(extra[group==2]-extra[group==1],data = sleep,exact = F))

#############################################################################################################

# 전국 출생률

mydata <- read.csv("data/paired.csv")
head(mydata)
tail(mydata)

mydata2<-melt(mydata,id =c("cities","ID"),variable.name = "year",value.name = "birth_rate")
mydata2

y_2010 <-subset(mydata2,year=="birth_rate_2010",birth_rate) # W = 0.90495, p-value = 4.333e-05 정규 x
y_2015 <-subset(mydata2,year=="birth_rate_2015",birth_rate) # W = 0.95951, p-value = 0.01947   정규 x

pd <- paired(y_2010,y_2015)
plot(pd,type="profile")

shapiro.test(mydata2$birth_rate[mydata2$year=="birth_rate_2010"])
shapiro.test(mydata2$birth_rate[mydata2$year=="birth_rate_2015"])

wilcox.test(birth_rate ~ year,data = mydata2)
t.test(birth_rate ~ year,data = mydata2,paired = T)
