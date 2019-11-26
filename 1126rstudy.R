#상관분석
#산점도
plot(cars$speed, cars$dist)

#상관계수 #method = (양적자료) pearson (순서형) kendall, spearman
cor(cars$speed, cars$dist, method="pearson")

#상관분석
cor.test(cars$speed, cars$dist, method = 'pearson')
#유의확률이 유의수준 0.05보다 작으므로 귀무가설을 기각할 수 있다.

#산점행렬도
plot(iris[,1:4])
pairs(iris[,1:4])
#plot과 pairs는산점행렬도 그릴때
iris[,1:4]

#상관계수 행렬
cor(iris[,1:4])

# Hmisc :: rcorr()
# 상관계수와 유의확률을 한꺼번에 계산해주는데 이건 matrix.
install.packages("Hmisc")
library(Hmisc)
test <- rcorr(as.matrix(iris[,1:4]), type = 'pearson')
#너무 작은 값이여서 값이 나오지 않으므로 test 변수로 지정해서 P만 보면 더 자세한 값을 볼 수 있다.
test$P

# psych :: corr.test() 
# 상관계수와 유의확률을 한꺼번에 계산해주는데 이건 dataframe.
install.packages("psych")
library(psych)
corr.test(iris[,1:4], method = 'pearson')

# corrplot :: corrplot()
# 산점행렬도를 작성해줌
install.packages("corrplot")
library(corrplot)
result <- cor(iris[,1:4])
#method = 그래프 모양, 
corrplot(result, method = 'circle', type = "upper")
corrplot(result, method = 'circle', order = 'hclust')
corrplot(result, method = 'number', order = 'hclust')
corrplot.mixed(result, lower = 'circle', upper = 'pie')
#.mixed는 lower와 upper를 다른형태의 그래프로 나타낼 수 있음.
#유의하지 않은 곳을 공백 insig = 'blank'
#색에 따라서 상관계수의 크기가 다르고
#모양의 크기에 따라 상관계수의 절대값 크기가 다름

#------------------------------------------------------------------#
#단순선형 회귀분석
df <- read.csv("http://goo.gl/HKnl74")
#놀이기구 만족도 데이터
str(df)
#rides:놀이기구, overall:전체 만족도
# 1. 회귀식의 추정
attach(df)
lm(overall~rides)
#선형모형 구하기

# 산점도 그리기
m1 <- lm(overall~rides)
plot(overall~rides, xlab = 'Satisfaction with Rides', 
     ylab = 'Overall Satisfaction')
abline(m1, col = 'blue')

# 2. 회귀모형의 검정 및 적합도 파악
summary(m1)
#Adjusted R-squared : 설명력, 보정된 R제곱, 결정계수

# 다중선형 회귀분석
m2 <- lm(overall~rides + games + clean)
summary(m2)

#----------------------------------------#
# Homework 예제
car <- read.csv("C:/Users/daess/Desktop/car.csv")
head(car)
car

# 결측치 제거
dim(car) #409행,13열
car <- car[complete.cases(car),] #각 행의 값이 NA가 아닐때는 TRUE. 결측치가 없는 행만 추출출
dim(car)

# 가변수 생성
unique(car$연료)
가솔린 <- NA #아무것도 없는 가솔린이라는 변수 만들기
디젤 <- NA #아무것도 없는 디젤이라는 변수 만들기
#가솔린, 디젤이라는 열을 새로 만들어서 car에 묶어주기
temp <- cbind(car, 가솔린, 디젤)
#새로 만든 가솔린, 디젤 열에 값채우기
temp$가솔린[temp$연료=="가솔린"] <- 1
temp$가솔린[is.na(temp$가솔린)] <- 0
temp$디젤[temp$연료 == "디젤"] <- 1 
temp$디젤[is.na(temp$디젤)] <- 0 
temp$가솔린 <- as.factor(temp$가솔린)
temp$디젤 <- as.factor(temp$디젤)
temp
temp <- temp[,-8]
temp

temp$년식 <- as.factor(temp$년식) 
temp$LPG <- as.factor(temp$LPG)
temp$회사명 <- as.factor(temp$회사명)
temp$종류 <- as.factor(temp$종류)
temp$하이브리드 <- as.factor(temp$하이브리드)
temp$변속기 <- as.factor(temp$변속기)

# 회귀모형 적합
fit <- lm(가격~., data = temp)
summary(fit)
#*가 없는 변수들은 유의하지 않은 변수들
#*가 없는 변수들이 있다면 완벽하지 않으므로 이 변수들을 없애주기.

# 변수 선택 (forward, backward, stepwise)
# forward
fit.null <- lm(가격~1, data = temp)
fit.forward <- step(fit.null, scope = list(lower = fit.null, upper = fit), direction = 'forward')

# backward
fit.backward <- step(fit, scope = list(lower=fit.null, upper = fit), direction = 'backward')

# stepwise
fit.both <- step(fit.null, scope = list(lower = fit.null, upper = fit), direction = 'both')
summary(fit.both)
fit <- lm(가격 ~ 마력 + 회사명 + 종류 + 배기량 + 하이브리드 + 
              중량 + 변속기 + 년식 + 연비 + 디젤 + 토크, data = temp)
# 회귀진단
#다중공선성
install.packages("car")
library(car)
install.packages("psych")
library(psych)

pairs(temp[names(temp)])
pairs.panels(temp[names(temp)])

vif(fit)
fit1 <- lm(가격 ~ 마력 + 회사명 + 종류 + 배기량 + 하이브리드 + 
               중량 + 변속기 + 년식 + 연비 + 디젤, data = temp)
vif(fit1)
fit2 <- lm(가격 ~ 마력 + 회사명 + 종류 + 배기량 + 하이브리드 + 
               변속기 + 년식 + 연비 + 디젤, data = temp)
vif(fit2)
fit3 <- lm(가격 ~ 마력 + 회사명 + 종류 + 하이브리드 + 
               변속기 + 년식 + 연비 + 디젤, data = temp)
vif(fit3)#다중공선성을 완벽하게 제거한 선형 모형식 선정정
summary(fit3)

# 이상치 제거
par(mfrow=c(2,2)) #그래프를 2x2 = 4개 그리기 #그래프 레이아웃 설정 변경해준다고 생각하면 됨.
plot(fit3)
par(mfrow=c(1,1)) #그래프가 1개씩 뜨는데 이때는 다음 그래프를 보기위해서 return을 써줘야함.
plot(fit3) 
#그래프를 보면 3,4,10의 이상치가 존재하므로 빼고 다시 선형모형을 만들기기
fit <- lm(가격 ~ 마력 + 회사명 + 종류 + 하이브리드 + 
              변속기 + 년식 + 연비 + 디젤, data = temp[-c(3,4,10),]) 
summary(fit) #이상치를 제거하기 전보다 결정계수가 좋아짐.
plot(fit)

#회귀모형으로 가격 예측
pre <- predict(fit, newdata = temp) #newdata에 변수별로 값이 나와있는데, fit에 temp의 값들을 대입.
pre <- as.data.frame(pre)
head(pre)
pre

#점이 아닌 하한과 상한이 존재하는 예측구간
pre <- predict(fit, newdata = temp, interval = 'predict')
pre <- as.data.frame(pre)
head(pre)

#얼마나 잘 예측되었는지 한눈에 확인하기
pre <- cbind(pre, temp$가격)

tf<-NA
pre<-cbind(pre, tf)
pre$tf[pre$`temp$가격`>= pre$lwr & pre$`temp$가격` <= pre$upr] <- T
pre$tf[is.na(pre$tf)] <- F
head(pre)
sum(pre$tf=='TRUE')/dim(pre)[1]
