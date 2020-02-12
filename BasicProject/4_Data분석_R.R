#############################################################################################
#plyr ,dplyr 
#############################################################################################
install.packages("plyr")
library(plyr)

# 데이터 병합
x <- data.frame(id=c(1,2,3,4,5,6),height=c(160,172,185,165,154,176))
y <- data.frame(id=c(5,4,1,3,2,7),weight=c(55,73,60,57,80,81))

xy<-join(x,y,by="id",type="left")
xy

xy<-join(x,y,by="id",type="right")
xy


xy<-join(x,y,by="id",type="full")
xy

xy<-join(x,y,by="id",type="inner")
xy

#다중key일 경우
x<-data.frame(key1=c(1,1,2,2,3),key2=c('a','b','c','d','e'),
              val=c(10, 20, 30, 40 ,50))
y<-data.frame(key1=c(3,2,2.1,1,1),key2=c('e','d','c','b','a'),
               val=c(500,400,300,200,100))

xy<-join(x,y,by=c("key1","key2"))
xy

# 기술 통계량 : tapply(), daply() 
# tapply(vector, index, function) : 집단 변수를 대상으로 한번에 하니의 통계치를 구할때 사용
# daply() : 한번에 여러개의 통계치를 구할 떄 사용

head(iris)
unique(iris$Species)

tapply(iris$Sepal.Length,iris$Species,mean)
tapply(iris$Sepal.Length,iris$Species,sd)

daply(iris,.(Species), summarise,avg = mean(Sepal.Length))
daply(iris,.(Species), summarise,avg = mean(Sepal.Length),std =sd(Sepal.Length),
      max=max(Sepal.Length),min=min(Sepal.Length))

#############################################################################################
#dplyr
#############################################################################################
install.packages("dplyr")
library(dplyr)
help(package="dplyr")

# filter()      : 행추출
# select()      : 열 추출
# arrange()     : 정렬
# mutate()      : 열추가
# summarise()   : 통계치 산출
# group_by()     : 집단별로 나누기
# left_join     : 데티어 합치기(열)
# bind_rows()   : 데이터 합치기(행)

exam=read.csv("data/csv_exam.csv")
exam

# 1반 학생들의 데이터 추출
exam[exam$class==1,]
exam%>%filter(class==1)

# 2반 이면서 영어점수가 80점 이상인 데이터 추출
exam[exam$class==2 & exam$english>=80,]
exam%>%filter(class==2 & english>=80)

# 1,3,5 반에 해당하는 데이터를 추출
exam[exam$class==1 | exam$class==3 | exam$class==5,]
exam%>%filter(class==1 | class==3 | class==5)
exam%>%filter(class %in% c(1,3,5)) # in문법 사용가능 

###select()
#------------

#수학 점수만 추출
exam[,3]
exam %>% select(math)

# 반, 수학, 영어점수 추출
exam %>% select(class,math,english)

#수학 점수를 제외한 나머지 컬럼 추출
exam %>% select(-math)

# 1반 학생들의 수학점수만 추출
exam %>% filter(class==1) %>% select(math)
exam %>% select(id,math) %>% head
exam %>% select(id,math) %>% head(10)

#### arrange()
#----------------------
exam %>% arrange(math)
exam %>% arrange(desc(math)) #내림차순 
exam %>% arrange(class,math) #반 별로 오름차순

### mutate()
#------------
exam$sum <-exam$math + exam$english + exam$science #열 추가
head(exam)

exam <- exam %>% mutate(total=math+english+science,mean=(math+english+science)/3)
exam

###summarise()
#---------------
exam%>% summarise(mean_math=mean(math))

###group_by()
#--------------
exam %>% group_by(class) %>%
  summarise(mean_math=mean(math),sum_math=sum(math),median_math=median(math),n=n()) #n()-전체갯수

###left_join()
#-------------
test1 <- data.frame(id=c(1,2,3,4,5),midterm=c(60,70,80,90,85))
test2 <- data.frame(id=c(1,2,3,4,5),midterm=c(70,83,65,95,80))

total <- left_join(test1,test2,by="id")
total

test3 <- data.frame(class=c(1,2,3,4,5),teacher=c("kim","lee","park","choi","jung"))
exam_new <- left_join(exam,test3,by="class")
head(exam_new)

###bind_rows()
#----------------
group1 <- data.frame(id=c(1,2,3,4,5),midterm=c(60,70,80,90,85))
group2 <- data.frame(id=c(6,7,8,9,10),midterm=c(70,83,65,95,80))
group_all <- bind_rows(group1,group2)
group_all

###############################################################################################
# 실습
###############################################################################################
install.packages("ggplot2")
library(ggplot2)

str(ggplot2::mpg)
head(ggplot2::mpg)

mpg <- as.data.frame(ggplot2::mpg)
#데이터 파악
dim(mpg)
str(mpg)
tail(mpg)
head(mpg)
View(mpg)
class(mpg)
names(mpg)

#기본 시각화
boxplot(mpg$displ)
hist(mpg$displ)
plot(mpg$displ)

# 배기량이 4이하인 차량의 모델명, 배기량, 생산년도를 출력
mpg %>% filter(displ<=4) %>% select(model,displ,year) 
select(filter(mpg,displ<=4),model,displ,year)
# 통합연비 파생변수를 만들고 통합연비로 내림차순 정렬을 한 후에 3개의 행만 선택해서 출력
# 통합연비 : total <- (도시연비(cty) + 고속도로 연비(hwy)) / 2
mpg$total <- (mpg$cty + mpg$hwy)/2
mpg %>% arrange(desc(total)) %>% head(3)

# 회사별로 "suv"차량의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지 출력
mpg %>% group_by(manufacturer) %>%filter(class=="suv") %>% summarise(total_mean=mean(total)) %>% arrange(desc(total_mean)) %>% head(5)

# 어떤 회사의 연비가 가장 높은지 알아보려고 한다. hwy평균이 가장 높은 회사 세곳을 출력하시오.
mpg %>% group_by(manufacturer) %>% summarise(hwy_mean=mean(hwy)) %>% arrange(desc(hwy_mean)) %>% head(3)

# 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다.
# 각 회사별 경차 차종 수를 내림차순으로 정렬해 출력
mpg %>% group_by(manufacturer) %>% filter(class=="compact") %>% summarise(n=n()) %>% arrange(desc(n))#순서를 filter 먼저 하는것이 빠른 케이스!

# 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 기존 데이터에 병합하여 출력하시오.
# c:CNG = 2.35, d:Disel = 2.38, e:ethanol = 2.11, p:Premium = 2.76, r:Regular = 2.22
fuel <- data.frame(fl=c('c','d','e','p','r'),name=c('CNG','Disel','ethanol','Premium','Regular'),price=c(2.35,2.38,2.11,2.76,2.22),stringsAsFactors = F)
mpg_new <- left_join(mpg,fuel,by="fl")
mpg_new
# 통합연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는 test라는 이름으로 파생변수 생성. 이때 기준은 20
mpg_new$test="pass"
mpg_new[mpg_new$total<20,"test"]="fail"
mpg_new
mpg_new$test <- ifelse(mpg_new$total>=20,"pass","fail")
mpg_new[total]
# test에 대해 합격과 불합격을 받은 자동차가 각각 몇대인가?
mpg_new %>% group_by(test) %>%summarise(n=n())
table(mpg_new$test)
# 통합 연비 등급을 A, B, C 세 등급으로 나누는 파생변수 추가 : grade
# 30이상이면 A, 20~29이면 B, 20미만이면 C등급으로 분류
mpg_new$grade="C"
mpg_new[mpg_new$total>=20,"grade"]="B"
mpg_new[mpg_new$total>=30,"grade"]="A"
mpg_new<-mpg_new[,-17]

mpg_new$grade <- ifelse(mpg_new$total>=30,"A",ifelse(mpg_new$total>=20,"B","C"))
####################################################################################
#미국 동부중부 437개 지역의 인구 통계 정보를 담은 데이터
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
# 전체 인구대비 미성년 인구 백분율(ratio_child) 변수를 추가
midwest <- midwest %>% mutate(ratio_child=(poptotal-popadults)/poptotal*100)
midwest
# 미성년 인구 백분율이 가장 높은 상위 5개 지역의 미성년 인구 백분율을 출력
midwest %>% arrange(desc(ratio_child)) %>% select(county, ratio_child) %>% head(5)

# 분류표의 기준에 따라 미성년 비율 등급 변수(grade)를 추가하고, 각 등급에 몇개의 지역이 있는지 알아보자.
# 미성년 인구 백분율이 40이상이면 "large", 30이상이면 "middle" 그렇지 않으면 "small"
midwest <- midwest %>%
  mutate(grade=ifelse(ratio_child>=40,"large",ifelse(ratio_child>=30,"middle",'small')))

# 전체 인구 대비 아시아인 인구 백분율(ratio_asian) 변수를 추가하고 하위 10개 지역의 state, country, 아시아인 인구 백분율을 출력하시오.

#####################################################################################
#### 데이터 전처리

# 순서 : 데이터 탐색 -> 결측치 처리 -> 이상치 처리 - Feature Engineering

# 데이터 탐색
#   1) 변수 확인
#       - 변수의 유형(범주형, 연속형, 문자형, 숫자형...)
#       - 단 변수일 경우 : 평균, 최빈값, 중간값, 분포
#       - 다 변수(2개)일 경우 : 관계, 차이 검정
#       - 다 변수(3개 이상)일 경우 : 관계, 차이 검정

# 결측치 처리
#   1) 삭제
#   2) 다른값으로 대체(평균, 최빈값, 중간값)
#   3) 예측값 : 선형 회귀분석, 로지스틱 회귀분석등을 이용

# 이상치 처리
#   1) 이상치 탐색
#       - 시각적 확인 : 산포도, 박스도표
#       - 통계적 확인 : 표준 잔차, leverage, Cook's D,...
#   2) 처리 방법
#       - 삭제
#       - 다른 값으로 대체
#       - 리샘플링(케이스별로 분리)

# Feature Engineering
#   1) Scaling : 단위 변경
#   2) Binning : 연속형 변수를 범주형 변수로 변환
#   3) Transform : 기존 존재하는 변수의 성질을 이용해 다른 변수를 만드는 방법
#   4) Dummy : 범주형 변수를 연속형 변수로 변환(Binning의 반대)

#####################################################################################

### 변수명 바꾸기
df_row <- data.frame(var1=c(1,2,3),var2=c(2,3,2))
df_row

# 내장함수
df_new1<-df_row
names(df_new1) <- c("v1","v2")
df_new1

# 패키지
library(dplyr)
df_new2 <- df_row
df_new2 <- rename(df_new2,v1=var1,v2=var2)
df_new2

#결측치 처리
#---------------------
dataset1<-read.csv("data/dataset.csv",header = T)
View(dataset1)
str(dataset1)
y<-dataset1$price
plot(y)

attach(dataset1)
price

detach(dataset1)
price

# 결측치 확인하기
summary(price)

# 결측치 제거
sum(price,na.rm = T) # NA

price2 <- na.omit(price) 
sum(price2)

#결측치 대체
data <- ifelse(!is.na(vec),vec,0)

### 이상치 처리
#----------------
table(gender)
pie(table(gender))

dataset1<- subset(dataset1,gender==1 | gender==2)
attach(dataset1)
table(gender)
pie(table(gender))

# 양적 자료
summary(price)

length(price)

boxplot(price)

dataset2<-subset(dataset1,price>=2&price<=8)
length(dataset2)
stem(dataset2$price)

#age의 이상치 처리

### Feature Engineering
View(dataset2)

dataset2$resident2[dataset2$resident==1]<-"1.서울특별시"
dataset2$resident2[dataset2$resident==2]<-"2.인천광역시"
dataset2$resident2[dataset2$resident==3]<-"3.대전광역시"
dataset2$resident2[dataset2$resident==4]<-"4.대구광역시"
dataset2$resident2[dataset2$resident==5]<-"5.부산시"

# Binning
# 나이변수를 청년층(30세이하), 중년층(31이하~55세 이하), 장년층(56세~ )으로 척도 변경
dataset2$age2="청년층"
dataset2$age2[dataset2$age>30]="중년층"
dataset2$age2[dataset2$age>56]="장년층"

# 역코딩을 위한 코드 변경
table(dataset2$survey)

survey <- dataset2$survey
csurvey <- 6-survey
dataset2$survey <- csurvey
head(dataset2)

#Dummy Data
#   거주유형 : 단독주택(1), 다가구주택(2), 아파트(3), 오피스텔(4)
#   직업유형 : 자영업(1), 사무직(2), 서비스(3), 전문직(4), 기타
user_data <- read.csv("data/user_data.csv",header = T)
View(user_data)

table(user_data$house_type)

house_type1 <- ifelse(user_data$house_type==1 | user_data$house_type==2,0,1)
user_data$house_type2 <- house_type1
head(user_data,10)

# 데이터의 구조 변경(wide type, long type) : melt(long), cast(wide)
# reshape, reshape2, ...
library(reshape2)

str(airquality)
head(airquality)

n1 <- melt(airquality,id.vars = c("Month","Day"))
n1

n2 <- melt(airquality,id.vars = c("Month","Day"),variable.name = "climate_var",value.name = "climate_val")
n2

dc1 <- dcast(n2, Month + Day ~ climate_var)
dc1

data <- read.csv("data/data.csv")
data

wide <- dcast(data,Customer_ID ~ Date)
wide

wide1 <- dcast(data,Customer_ID ~ Date, mean)
wide1

img <- melt(wide,id="Customer_ID")
img

pay_data <- read.csv("data/pay_data.csv")
pay_data
#user_id를 기준으로 product_type를 wide하게 펼쳐보시오(결과는 합계로 )
wide2 <- dcast(pay_data,user_id~product_type,sum)
wide2

################################################################################################################

### mysql 연동

install.packages("rJava")
install.packages("DBI") 
install.packages("RMySQL")

library(RMySQL)

conn <- dbConnect(MySQL(),dbname="rtest", user="root", password="intel960", host="127.0.0.1")
conn

#테이블 목록 확인
dbListTables(conn)

#전체 데이터 갯수조회
result <- dbGetQuery(conn,"select count(*) from tblscore")
result
class(result)

#전체 데이터 조회
result <- dbGetQuery(conn,"select * from tblscore")
result
class(result)

#테이블의 필드 목록
Fields<-dbListFields(conn,"tblscore")
class(Fields)

#DML
dbSendQuery(conn,"delete from tblscore")

result <- dbGetQuery(conn,"select * from tblscore")
result

# 파일로 부터 데이터를 읽어들여 DB에 저장
score <- read.csv("data/score.csv",header = T)
score

dbWriteTable(conn,"tblscore",score,overwrite=T) #인덱스 이름이 들어가 버림
dbSendQuery(conn,"drop table tblscore")
dbWriteTable(conn,"tblscore",score,overwrite=T,row.names=F)

dbDisconnect(conn)

detach("package:RMySQL",unload = T) # 라이브러리 메모리에서 언 로드
###############################################################################################
# sqldf : R + SQL 을 한것 
#-----------------------------
install.packages("sqldf")

library(sqldf)

head(iris)
sqldf("select * from iris limit 5")
sqldf("select * from iris order by Species desc limit 10")
sqldf('select sum("Sepal.Length") from iris')
sqldf('select max("Sepal.Length") from iris')
sqldf('select distinct Species from iris')

#품종 별로 갯수 확인
sqldf("select Species, count(*) from iris group by Species")
