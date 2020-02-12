#update.packages()
###################################################################################
# 1.변수                                                                          #  
###################################################################################

goods='냉장고'
goods

# 변수 사용시 객체형태로 사용하는 것을 권장
# 변수는 모든 데이터 저장 가능(함수, 차트, 이미지, ...)
goods.name="냉장고"
goods.code="ref001"
goods.price=600000.0

goods.name

# 값을 대입할 때는 = 보다는 <- 를 권장
goods.name <- "냉장고"
goods.code <- "ref001"
goods.price <- 600000.0

goods.price

# Datatype 확인
class(goods.name)
mode(goods.price)

#도움말 활용
help(sum)


args(sum)


example(sum)
###################################################################################
# 2.데이터 타입
# 자료 구조
# ---------
# 백터(1차원),매트릭스(2차원), 데이터 프레임(2차원)-파이썬에서는 따로 R은 기본,
# array(3차원 이상)-1차원도 가능하지만 불편함
# List(3차원 이상-다차원)
###################################################################################

###백터
#-------
# 1) R에서 가장 기본이 되는 자료구조
# 2) 1차원 배열
# 3) 변수[index]로 접근(시작 인덱스 1부터 시작)
# 4) 동일한 자료형만 저장
# 5) c(),seq(),rep() - 백터를 생성하는 기본 함수

v <- c(1,2,3,4,5)
v
mode(v)

(v <- c(1,2,3,4,5))

class(c(1:5))
mode((1:5))

class(c(1,2,3,4,"5")) # 자동 형변환이 일어남 (배열이기 떄문에)

# seq()
help(seq)
seq(from=1,to=10,by=2) #seq(1,10,2)

#rep()
help(rep)
rep(x=1:3,times=3)
rep(1:3,3)

rep(1:3,each=3)

#집합 연산
x <- c(1,3,5,7)
y <- c(3,5)

union(x,y)      #합집합
setdiff(x,y)    #차집합
intersect(x,y)  #교집합

#백터의 컬럼명 지정
age <- c(30, 35, 40)
names(age) <- c("홍길동","임꺽정","신들석")
age

age <- NULL #데이터 초기화
age

#백터의 접근
a <- c(1:50)
a[10:45]
a[10:(length(a)-5)]
a[10:length(a)-5]

b <- c(13, -5, 20:23, 12, -2:3)
b[1]
b[c(2:4)]
b[c(4,5:8,7)]

#제외
b[-1]
b[-2]
b[-3]
b[-c(2,4)]


### 팩터(Factor)
gender <- c("man","women","women","man","man")
gender
class(gender)
is.factor(gender)
plot(gender)

fgender <- as.factor(gender)
fgender
class(fgender)
mode(fgender)
is.factor(fgender)
table(fgender)
plot(fgender)

#factor
sgender <- factor(gender, levels = c("women","man"))
sgender

### matrix
# 1) 행과 열의 2차원 배열
# 2) 동일한 데이터 타입만 저장 가능
# 3) matrix(), cbind()-행 합쳐주는, rbind()-열을 합쳐주는

#m <- matrix(data, nrow = rows, ncol = cols)
m <- matrix(c(1:5))
m

n <- matrix(c(1:10),nrow = 2)
n

class(n)
mode(n)

# 행, 열을 합쳐 matrix 생성
m2 <- c(3,4,50:52)
n2 <- c(30,5,6:8,7,8)

ac <- cbind(m2,n2)
ac

ar <- rbind(m2,n2)
ar

# 접근
ar
ar[1,]
ar[,4]
ar[2,3]
ar[2,3:5]

#활용
x <- matrix(c(1:9),ncol=3)
x

length(x); nrow(x); ncol(x);

#apply
#apply(array, margin, ...)
apply(x, 1,max) #행별로
apply(x, 2,max) #열별로

apply(x,1,mean)
apply(x,2,mean)

colnames(x) <- c("one", "two", "three")
x

### 데이터 프레임 
# 1) DB의 테이블과 유사
# 2) R에서 가장 많이 사용하는 구조
# 3) 컬럼 단위로 서로 다른 데이터타입 사용 가능
# 4) dataframe(), read.table(),read.csv(

no <- c(1,2,3)
name <- c("hong", "lee", "kim")
pay <- c(150, 250, 350)

emp <- data.frame(num = no, name=name, payment=pay)
emp

mat_emp=matrix(c(no,name,pay),nrow=3)
mat_emp
colnames(mat_emp) <- c("no","name","payment")
mat_emp;

# 외부 파일을 이용하여 데이터 프레임 생성
txtemp=read.table("c:/Users/kjjs1/ProjectFileKim/Rwork/BasicProject/data/emp.txt",header = T,sep=" ")
txtemp
class(txtemp)

gettext()
txtemp1=read.table("data/emp.txt",header = T,sep = " ")
txtemp1

csvemp <- read.csv("data/emp2.csv",header = T)
csvemp

csvemp2 <- read.csv("data/emp2.csv",header = F, col.names = c("사번","이름","급여"))
csvemp2

View(csvemp2)

#접근 데이터 프레임
csvemp2$사번
csvemp2[,1]
csvemp2[-1,-2] #1행 뺴고(101열) 2열 빼고(이름)
class(csvemp2[-1,-2])

# 데이터프레임의 구조 확인
str(csvemp2)
# $ 이름: Factor w/ 5 levels "강감찬","산들석",..: 5 3 1 2 4 문자열로 저장되어있는 외부 파일은
# Factor로 불러옴

csvemp3 <- read.csv("data/emp2.csv",header = F, col.names = c("사번","이름","급여"),stringsAsFactors=F)
str(csvemp3) #stringsAsFactors=F 이 옵션을 주면 문자열을 팩터로 가져오지 않음

summary(csvemp3) #기본 통계값 확인
summary(csvemp3["급여"])

#apply 사용
df <- data.frame(x=c(1:5),y=seq(2,10,2),z=c('a','b','c','d','e'))
apply(df[,-3],1, sum)
apply(df[,-3],2, sum) # df[,-3] 대신 df[,c[1,2]] 가능

# 데이터의 일부를 추출해서 별도의 데이터프레임 생성
x1 <- subset(df,x>=3)
x1

xandy <- subset(df, x>=2 & y<=6)
xandy

# 병합
height <- data.frame(id=c(1,2),h = c(180,175))
weight <- data.frame(id=c(1,2),h = c(80,75))
user <- merge(height,weight,by='id')
user

### array (다차원을 다루는 방법)
#-------------------------------
# 1) 행, 열, 면의 3차원 배열 형태의 객체를 생성
# 2) array()

vec <- c(1:12)
arr<-array(vec,c(3,2,3))
arr

#array 접근
arr[, , 1]
arr[, , 2]

#5라는 값 출력해보기/8이라는 값 출력해보기
arr[2, 2, 1]
arr[2, 1, 2]

### List
#------------
# 1) key와 value가 한쌍
# 2) 파이썬에서 dict와 유사
# 3) list()

a<-1
x1 <- data.frame(var1=c(1,2,3),var2=c('a','b','c'))
x2 <- matrix(c(1:12),ncol = 2)
x3 <- array(1:20,dim=c(2,5,2))

x4<-list(f1=a,f2=x1,f3=x2,f4=x3)
x4

x4$f1
x4$f2
x4$f3
x4$f4

list1 <- list("lee","이순신",95)
list1
list1[1]
list1[[1]]

ut <- unlist(list1)
ut
class(ut)

list2 <-  list(id="lee",name="이순신",age=30)
list2
list2[[1]]
list2$id

#apply 활용 
a <- list(c(1:5))
b <- list(6:10)
a
b

c <- c(a,b)
c
class(c)

x <- lapply(c,max) #리턴값이 리스트
x
y <- sapply(c,max) # 리턴값이 백터
y

#############################################################################################
###날짜형
#----------
Sys.time()

a <- "20/12/21"
a
class(a)

as.Date()
help(as.Date)
b<-as.Date(a,"%y/%m/%d")
class(b)
b

#############################################################################################
### 문자열 :stringr
install.packages("stringr") #패키지 설치 install.packages("패키지 명")

library(stringr) #require(패키지명) 

str1 <- c("홍길동35이순신45임꺽정25강감찬37")
str_extract(str1,"\\d{2}")
str_extract(str1,"[0-9]{2}") #하나만 

str_extract_all(str1,"\\d{2}")

str_locate(str1,"강감찬")

str3 <-c("hongkd105,Tess1002,you25,TOm400,강감찬2005")
str_split(str3,",")
