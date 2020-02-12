### 키보드 입력 : scan(), edit()
#scan() 백터 입력
#edit() 데이터 프레임 입력
#---------------------------------

# 숫자 입력
a <- scan()
a

# 문자 입력
b <- scan(what = character()) #백터로 저장된다 / what=""해도 된다
b

df <- data.frame()
df <- edit(df)
df

####################################################################################
# 파일 입력 : read.table()-형식이 없는 일반파일,read.xlsx(),read.csv()
#----------------------------------------------------------------------------------

student <- read.table("data/student.txt") #제목이 없는 파일
student
names(student) <- c("번호","이름","키","몸무게")
student

student1 <- read.table(file="data/student1.txt",header = T) #제목이 있는 파일
student1

student2 <- read.table(file.choose(),header = T) #제목이 있는 파일 - 탐색기에서 선택
student2

student3 <- read.table(file.choose(),header = T,sep="/") #제목이 있는 파일 - 탐색기에서 선택
student3

student4 <- read.table(file.choose(),header = T,sep="/",na.strings = "-") #결측치 표시
student4

student4 <- read.table(file.choose(),header = T,sep="/",na.strings = c("-","","&","+")) #결측치 표시
student4

read.xlsx()
install.packages("xlsx")
library(xlsx)

xstudent <- read.xlsx(file.choose(),sheetIndex = 1,encoding = "UTF-8")
xstudent <- read.xlsx(file.choose(),sheetName = "emp2",encoding = "UTF-8")
xstudent

##############################################################################################
###웹 문서 입력
#---------------
install.packages("httr")
install.packages("XML")

library(httr)
require(XML)

url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"
get_url<-GET(url)
get_url

html_content <- readHTMLTable(rawToChar(get_url$content)) #테이블 자료만 가져옴
html_content
class(html_content) #가져오는 자료형식은 list
str(html_content) # 팩터 형식으로 변환

df<-as.data.frame(html_content) #데이터 프레임으로 가져오기
df

#############################################################################################
### 화면출력 : 변수명, (), cat(), print() 
#--------------------------------------------
x <- 10
y <- 20
z <- x+y

z
(z <- x + y)

print(z)
print(z <- x + y)
print("x + y의 결과는 "+as.character(z)+"입니다")
cat("x + y의 결과는 ",as.character(z),"입니다")
cat("x + y의 결과는 ",z,"입니다")

### 파일 출력
#------------
#wrrite.table(), write.csv()
xstudent <- read.xlsx(file.choose(),sheetIndex = "1",encoding = "UTF-8")
xstudent

write.table(xstudent,"data/stud1.txt")
write.table(xstudent,"data/stud2.txt",row.names = F)
write.table(xstudent,"data/stud3.txt",row.names = F,quote = F)

write.csv(xstudent,"data/stud4.csv",row.names = F,quote = F)

#write.xlsx()
write.xlsx(xstudent,"data/stud5.xlsx")

# save(),load() : 주로 rda파일을 다룰 떄 사용(R 전용 2진 파일 - 속도가 빠름)
save(xstudent,file="data/stud5.rda") 

rm(xstudent) # 특정 변수만 메모리에 서 삭제
xstudent

load("data/stud5.rda")
xstudent

# sink() - 이 함수를 실행하고 아래의 동작결과를 커맨드 창이 아닌 메모장에 자동 저장해줌 #
data()

data(iris)

head(iris)
tail(iris)

sink("data/iris.txt")

head(iris)
tail(iris)
str(iris)

sink()

head(iris)
