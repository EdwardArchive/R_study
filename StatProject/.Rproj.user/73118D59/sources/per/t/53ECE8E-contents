# 난수 발생
x <- runif(1) #runif(n) n은 횟수 / 0~1 까지의 균일 분포,rnorm() - 비슷한 함수
x

### 조건문
#----------
# x가 0보다 크면 절대값(abs)을 화면 출력
if(x>0){
  cat("TRUE",abs(x))
}

if(x>0) cat("TRUE",abs(x))

# x가 0.5 보다 작으면 1-x를 출력하고 그렇지 않으면  x를 출력해라
if(x<0.5){
  cat("true",1-x)
}else{ 
  cat("false",x)
}

if(x<0.5) cat("TRUE",abs(x)) else cat("false",x)

ifelse(x<0.5,1-x,x)

#다중 조건문
avg <-scan()

if(avg>=90){
  print("당신의 학점은 A입니다")
}else if(avg>=80){
  print("당신의 학점은 B입니다")
}else if(avg>=70){
  print("당신의 학점은 C입니다")
}else if(avg>=60){
  print("당신의 학점은 D입니다")
}else{
  print("재시험!!!")
}

## switch(), witch(), any(), all()
a <- "중3"
switch (a,"중1"=print("14살"),"중2"=print("15살"),"중3"=print("16살"))
switch (a,"중1"="14살","중2"="15살","중3"="16살")

b<-3
switch(3,"14살","15살","16살")  #자동적으로 인덱스 값을 할당하고 비교

avg <- avg%%10
switch(as.character(avg),"9"="당신의 학점은 A입니다","8"="당신의 학점은 B입니다","7"="당신의 학점은 C입니다","6"="당신의 학점은 D입니다","F") 

res<-switch(as.character(avg),"9"="A","8"="B","7"="C","6"="D","F")

cat("당신의 학점은 : ",res,"입니다.")

# which() 특정값의 위치를 찾을 때
x <- c(2:10)

which(x==3)
x[which(x==3)]

#메트릭스에서 활용하기

m <-matrix(1:12,3,4)
m
which(m%%3==0)  #기본값이 index false
which(m%%3==0,arr.ind = T)
which(m%%3==0,arr.ind = F)

###연습
data(trees)
head(trees)

#hight 컬럼이 70미만인 행의 위치
which(trees$Height<70,arr.ind = T)

#행 출력 
trees[which(trees$Height<70,arr.ind = T),]

#최대 최소값
trees[which.max(trees$Height),]
trees[which.min(trees$Height),]
trees$Height

### any()

x <- runif(5)
# x 중에서 0.8 이상이 있는가?
any(x>=0.8)

# x값이 모두 0.9 이하인가?
all(x<=0.9)

#############################################################################################
### 반복문 : for, while, repeat
#---------------------------------------

sum <- 0
for (i in seq(1,10,by=1)) {
  sum <- sum + i
}
sum
sum <- 0
for (i in seq(1,10,by=1)) sum <- sum + i
sum
# 구구단 입력
print("단 입력 : ")
dan <-scan()
for(i in seq(1,9)) cat(dan," X ",i," = ",dan*i,"\n")

dan <-as.integer(readline("단 입력: "))
for(i in seq(1,9)) cat(dan," X ",i," = ",dan*i,"\n")

#구구단 출력
for(i in seq(2,9)){
  cat("===============",i,"단===============\n")
  for( j in seq(1,9)){
    cat(i," X ",j," = ",i*j,"\n")
  }
}

#while
sum <- 0
cnt <- 1
while(cnt <=10){
  sum <- sum + cnt
  cnt <- cnt+1
}
sum

# repeat : 최소 1번 이상의 반복을 보장받을 수 있다\
sum <- 0
cnt <- 1
repeat{
  sum <- sum + cnt
  cnt <- cnt+1
  if(cnt>10)
    break
}
sum

##############################################################################
### 함수
#--------------------------------

#인자 없는 함수
test1 <- function(){
  x <- 10
  y <- 10
  return(x*y)
}
test1()

#인자 있는 함수()
test2 <- function(x,y){
  xx<-x
  yy<-y
  return(sum(x,y))
}
test2(10,20)
test2(y=20,x=10) #순서를 모를떄는 인자를 연결해서 사용한다

#가변인수 ... -같은 형식이 들어올수 가 없을수 있다(list로 받기),
test3 <- function(...){
  args <- list(...)
  for(i in args) print(i)
}

test3(3,4)
test3(3,4,5,6)
test3("3",4,"hong","2012-02-12")

test4 <- function(a, b, ...){
  cat("a =",a," b =",b,"\n")
  test3(...)
}
test4(10,20,30,40)

# 중첩 함수
test5 <- function(x,y){
  print(x)
  
  test6 <- function(){
    print(y)
  }
  test6()
}
test5(10,20)

##################################################################################
### 기술통계량 처리 관련 내장함수
#-------------------------------------------
# min(),max()
# range() : Vector를 대상으로 범위값을 구하는 함수(최대값-최소값)
# mean()-평균,median()-중앙값
# sum()
# sort() : 백터 데이터 정렬(단, 원본의 값은 변경되지 않는다)
# order() : 정렬된 값의 인덱스를 보여주는 함수
# rank()
# summary()
# table()
# sd()

test <- read.csv("data/test.csv",header = T)
head(test)

#한번에 함수 호출로 다수의 컬럼에 대한 통계량을 계산하는 기능
# 각 컬럼단위로 빈도와 최대값/최소값 계산 함수 정의
data_proc <-function(df){
  for (idx in 1:length(df)){
    cat(idx,"번쨰 컬럼의 빈도분석 결과")
    print(table(df[idx]))
    cat("\n")
  }
  
  for(idx in 1:length(df)){
    f <- table(df[idx])
    cat(idx,"번쨰 컬럼의 최대값/최소값 결과\n")
    cat("min = ",min(f)," max = ",max(f),"\n")
  }
}
data_proc(test)

# 결측치 처리
data <-c(10,20,4,3,40,7,NA,6,3,NA,2,NA)

my_na <- function(vec){
  # 제1차 : 결측치를 제거하고 평균 계산
  print(mean(vec))
  print(mean(vec, na.rm = T))
  
  # 제2차 : 결측치를 0으로 대체하고 평균 계산
  data <- ifelse(!is.na(vec),vec,0)
  print(mean(data))
  
  # 제3차 : 결측치를 평균으로 대체하고 평균 계산
  data <- ifelse(!is.na(vec),vec,mean(vec, na.rm = T))
  print(mean(data))
}

my_na(data)
