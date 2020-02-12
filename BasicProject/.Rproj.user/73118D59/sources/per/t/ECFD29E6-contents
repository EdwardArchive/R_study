install.packages("ggplot2")
library(ggplot2)
library()
str(ggplot2::mpg)
head(ggplot2::mpg)

mpg <- as.data.frame(ggplot2::mpg)
View(mpg)
midwest <- as.data.frame(ggplot2::midwest)
#1
mpg %>% filter(displ<=4) %>% summarise(hwy_mean=mean(hwy)) %>% arrange(desc(hwy_mean))
mpg %>% filter(displ>=5) %>% summarise(hwy_mean=mean(hwy)) %>% arrange(desc(hwy_mean))


#2
#---
View(midwest)
# 전체 인구대비 미성년 인구 백분율(ratio_child) 변수를 추가
midwest <- midwest %>% mutate(전체_인구대비_미성년_인구_백분율=(poptotal-popadults)/poptotal*100) %>% 
  arrange(desc(전체_인구대비_미성년_인구_백분율)) %>% head(5) %>% select(county, 전체_인구대비_미성년_인구_백분율)
midwest
#3
#---
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)
class(mpg$drv)
table(mpg$drv)

mpg <- mpg %>% filter(drv %in% c('f','4','r'))
head(mpg,10)
4
#---
mpg$tot <- (mpg$cty + mpg$hwy) / 2

df_comp1 <- mpg[mpg$class == "compact", ]
df_suv1 <- mpg[mpg$class == "suv", ]

df_comp1
mean(df_comp$tot)
mean(df_suv$tot)

mpg <- as.data.frame(ggplot2::mpg)
#---------------

mpg <- mpg %>% mutate(tot=(mpg$cty + mpg$hwy) / 2)

df_comp <- mpg %>% filter(class=="compact")
df_suv <- mpg %>% filter(class=="suv")

df_comp %>% summarise(mean(tot))
df_suv %>% summarise(mean(tot))

#5
#-----
ggplot(midwest,aes(x=midwest$poptotal,y=midwest$popasian)) +geom_point() +xlim(0,500000) + ylim(0,10000)

#6
#---
mfc_mean <- mpg %>% group_by(manufacturer) %>% filter(class=="suv") %>% 
  summarise(manufacturer_mean=mean(cty)) %>% arrange(desc(manufacturer_mean)) %>% head(5)
ggplot(mfc_mean,aes(reorder(mfc_mean$manufacturer,-mfc_mean$manufacturer_mean),mfc_mean$manufacturer_mean)) + geom_col()
