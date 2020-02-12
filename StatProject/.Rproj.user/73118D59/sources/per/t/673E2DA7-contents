#명목 and 명목#
########################################################
# Chi Square test - 데이터를 테이블로 만들어서 넘겨주어야함
# Fisher's exact  test - Chi Square 의 기대도수에 못미치는 불안감이 있을경우 사용할수 있다.
# cochran armitage trend test
########################################################
#DATA
head(mtcars)

#자동차의 실린더 수와 변속기의 관계
table(mtcars$cyl)
table(mtcars$am)

# 가독성을 위해 테이블 수정
mtcars$tm <- ifelse(mtcars$am==0,"automatic","manual")
result <- table(mtcars$cyl,mtcars$tm)
result
addmargins(result)

chisq.test(result)
# 경고메시지(들): 
# In chisq.test(result) : 카이제곱 approximation은 정확하지 않을수도 있습니다
# -> 카이제곱은 각 쉘이 기대도수가 있다. 쉘마다 데이터의 갯수가 충분해야 한다

fisher.test(result)

###########################################################
# 흡연자, 비흡연자, 과거흡연자와 고혈압(HBP)의 유무 - cochran(흡연자에 트랜드(레벨이 존재함)) 
# cochran armitage trend test : prop.trend.test()
# prop.trend.test(x, n, score = seq_along(x))

str(acs)
table(acs$HBP,acs$smoking)

#컬럼의 순서를 바꾸기
acs$smoking <- factor(acs$smoking, levels = c("Never","Ex-smoker","Smoker"))
result <- table(acs$HBP,acs$smoking)
result

# x에 해당 하는 값(이벤트 발생횟수): 고혈압 발생 횟수
result[2,]

# n에 해당 하는 값(흡연 여부) : 열의 갯수
colSums(result)

prop.trend.test(x=result[2,],n=colSums(result)) #p-value = 9.282e-11 관계가 매우 높다

mytable(smoking~age,data=acs) # 오히려 젊은 사람들이 담배를 피고 있다 나이는 교란변수

###시각화

# 모자이크 그래프
mosaicplot(result,color =c("tan1","firebrick2"))

colors() #색상 함수
demo("colors")
par(mfrow=c(1,1))
t(result)
mosaicplot(t(result),color =c("tan1","firebrick2"),ylab = "Hypertension",xlab = "Smoking")

#############################################################################################################
#시군구에 따라 다자녀 조례 채택여부가 연관이 있는가?
mydata <- read.csv("data/anova_two_way.csv")
mydata

table(mydata$ad_layer)
table(mydata$multichild)

result <- table(mydata$multichild,mydata$ad_layer)
t(result)

fisher.test(result) # 시군구에 따라 다자녀 조례 채택여부는 관련이 없다

?chisq.test()
