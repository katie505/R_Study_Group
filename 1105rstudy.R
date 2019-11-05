rm(list = ls())
# 데이터 불러오기 & 확인 -----------------
setwd('C:/Users/daess/Desktop')
getwd()

# 1.  plot()  ---------------------------- r의 내장함수, 화려한 그래프를 그릴 수 없어서 ggplot으로 함.
#  :: level별 그래프 보기
DF = read.csv('C:/Users/daess/Desktop/example_studentlist.csv')
head(DF)
str(DF)
plot(DF$age)
#attach(DF)하면 내가 앞으로 쓰는 plot에는 age만 써도 DF$age로 읽힘. 근데 attach, detach는 충돌
#가능성이 있기 때문에 쓰지 않기!
plot(DF$height ~ DF$weight) #','는 순서대로 x축y축으로 지정되지만 '~'는 뒤에 나오는 독립, 앞이 종속변수로 지정됨.
plot(DF$height, DF$sex) #sex는 명목형 변수로 남자는 1, 여자는 0임
plot(DF$height ~ DF$sex) #boxplot으로 나옴. sex가 명목형이므로 성별에 따른 box plot이 나옴.
DF2 = data.frame(DF$height,DF$weight,DF$age)
plot(DF2)
plot(DF)
#plot은 명목형이랑 수치형. 'as.factor'함수로 명목형변수로 바꿔서 plot을 그림.

# Q. 몸무게와 키의 산포도 그래프를 나타내면서 *점의 종류*는 남자와 여자를 별도로 표시
plot(DF$height,DF$weight,pch=as.numeric(DF$sex))
legend('topleft',c('남','여'), pch=DF$sex)

#coplot 조건화그래프
coplot(DF$weight~DF$height|DF$sex)

#그래프 꾸미는 옵션들
plot(weight~height, ann = F) # ann옵션은 어떠한 라벨도 출력X
title(main = "키-몸무게 상관관계")
title(xlab="키", ylab="몸무게")
grid()
abline(v = mean(height), col="lightblue")  #세로 수직선
abline(h = mean(weight), col="lightpink")  #가로 수평선

############################################################################################


# 2. barplot -------------------------------------table함수

freq_blood = table(DF$bloodtype)
barplot(freq_blood)
title(xlab="혈액형",ylab="빈도수", main = "혈액형별 빈도수")
#tapply(벡터,레벨,적용함수) : 명목형변수의 레벨별로 함수를 적용해서 값을 구함
height_1 = tapply(DF$height, DF$bloodtype, mean)
height_1 #혈액형별 키평균
barplot(height_1, ylim = c(0,200)) #y축 키의 범위를 0에서 200으로

#Q. 혈액행별로 몇 명 있는지?



# Q. 제목: 혈액형별 빈도수 ,y축: 빈도수, x축: 혈액형



# 3. boxplot ---------------------------------------------------------------------------
boxplot(DF$height)

#Q. 레벨별로 구분하려면? :blood type별로 키 구하기 by using plot()
boxplot(DF$height~DF$bloodtype)
plot(DF$height,DF$bloodtype)

# Q. boxplot() ftn 으로 나타내기 



# 그래프 해석?
# : 1.이상치존재 
# : 2.AB형이 평균적으로 키가 크다. 


################################################################################################

#. ggplot2, ggthemes
library(ggplot2)
library(ggthemes)
# 예시 - 이해할 필요는 X, for ggplot의 쓰임새 간략히 보기 -----------------------------------

#한번에 표현
ggplot(data = diamonds, aes(x=carat, y=price, colour=clarity)) +
  geom_point() +
  theme_wsj()
# 따로따로
g1 = ggplot(data = diamonds, aes(x=carat, y=price, colour=clarity))
g2 = geom_point()
g3 =theme_wsj()
g1 + g2 + theme_bw()
#---------------------------------------------------------------------

# 1. aes :: 미적 요소 매핑 (aesthetic mapping)
g1 = ggplot(DF, aes(x =height, y=weight, colour=bloodtype))
g1 + geom_point() #점 ()안에는 g1에서의 값을 그대로 가져오므로 다시 언급할 필요x
g1 + geom_line() #선

#geom_point와 line은 g1의 객체를 그대로 받아서 그래프를 그림
g1 + geom_point() + geom_line()
g1 + geom_point(size = 10) + geom_line(size = 1) #점의 굵기, 선의 길이 등을 조절할 수 있음.

#aes는 다시 정의할 수 있음
g1 + geom_point(size = 10) + geom_line(aes(colour=sex), size = 1) #legend에 성별이 추가됨


# 3. facet_grid() ---------------------
# :: 명목형 변수를 기준으로 나눠서 별도의 그래프를 그려 줌
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(.~sex) # 독립변수가 sex
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(sex~.) # sex가 종속변수
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(sex~., scales="free") #각각의 스케일을 가질 수 있도록 #각각의 변수에 맞춰서 그래프가 나옴. 빈공간 줄이기
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_grid(.~sex, scales="free") #적용X
g1 + geom_point(size = 10) + geom_line(size = 1) + facet_wrap(~sex, scales="free") #y축에서 적용시킬 때 !

#둘의 차이 ?


# 4. geom_bar()  -----------------------------------

ggplot(DF, aes(x=bloodtype)) + geom_bar()
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar()
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="dodge")
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="identity") #빨강 앞에 파랑 겹쳐/ 빨강과 파랑이 겹치는 부분은 파란색으로 덮여있음
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="fill")  #누적 그래프 원할 때, 전체를 채우는 바 그래프!, 도수가 아니라 비율 
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="dodge", width=0.5)  #그래프 넓이 조정 가능

# 5. geom_histogram  -------------------------------

#geom_histogram() 안에 계급을 알려 주면 그래프를 바로 그려 줌
g1 = ggplot(diamonds, aes(x=carat))
g1 + geom_histogram(binwidth=0.1, fill="skyblue") #y축은 자동으로 도수, 
#밀도로 나타내려면?
g1 + geom_histogram(aes(y=..count..), binwidth=0.1, fill="white")

#..count.. :예약어, for 데이터프레임과의 혼용 막음
g1 + geom_histogram(aes(y=..ncount..), binwidth=0.1, fill="lightpink") #표준화된 도수값
g1 + geom_histogram(aes(y=..density..), binwidth=0.1, fill="orange") #밀도값으로 show
g1 + geom_histogram(aes(y=..ndensity..), binwidth=0.1, fill="violet") #표준화된 밀도값으로 show

# +) hist(): breaks 안에 개수를 넣음, but geom_hist는 계급의 단위 넣는 차이!

#Q. facet_grid()로 명목형 변수별로 따로따로 그래프를 그리려면?

# Q. color 변수의 level별로 그리기 명령 
g1 + geom_histogram(binwidth=0.1, fill="darkblue") + facet_grid(color~.) #y축이 동일 간격-> 맨아래쪽 기상해
g1 + geom_histogram(binwidth=0.1, fill="orange") + facet_grid(color~., scale="free") #그래프 보기 편행!

#level별로 겹쳐서 보려면?
g1 + geom_histogram(binwidth=0.1, aes(fill=color), alpha=0.5) #alpha는 투명도를 의미함함

# ->> ggplot2에서는 hist()보다는 다양한 방법으로 히스토그램이 표현됨
# so, 서교 비교를 요하는 명목병 변수가 있을 때는 geom_hist 이용해서 그리는 게 더 빠르고 정확! 


# 6. geom_point (산점도)  -------------------------------

# :: 기본 사용법
DF
g1 = ggplot(DF, aes(x=weight, y=height))
g1 + geom_point()

# Q. 명목형 변수의 레벨별로 컬러를 다르게 나타내려면? 레벨:성별(sex)
g1 + geom_point(aes(color=sex), size=7) #범례가 자동으로 추가됨!

# Q. 성별(sex) 별로 색을 다르게 하고, 각 성별에서는 혈액형(bloodtype)별로 점모양 다르게 하려면?
g1 + geom_point(aes(color=sex, shape=bloodtype), size=7) #점 모양 바꾸기

# Q. color에 연속형 변수넣기 가능? (O)
g1 + geom_point(aes(color=height, shape=sex), size=7)

# Q. size에  연속형 변수 넣기?
g1 + geom_point(aes(size=height, shape=sex), color="orange") #size 인자에 연속형 변수가 반영

# +) apha값으로 그래프 꾸미기
g1 + geom_point(aes(color=sex, shape=bloodtype), size=7, alpha=0.6)

# +) 회귀분석 - 두 변수의 관계를 함수식으로 나타내기 - geom_smooth
g1 + geom_point(aes(color=sex), size=7) + geom_smooth(method="lm", color="grey35")

# +) 자료가 몇 개 없는 경우, 점마다 이름을 넣을 수 있음
g1 + geom_point(aes(color=sex), size=7) + geom_text(aes(label=DF$name))

# Q. 점과 라벨이 겹치지 않게 하려면? : 위치 조정 need by vjust()
g1 + geom_point(aes(color=sex), size=3) + geom_text(aes(label=DF$name), vjust=-1.1, color="grey35") + theme_void()



##############################################################################

# ++) theme() 함수


##############################################################################

# 추가 예제. 규모가 큰 시계열 데이터 다루기

library('dplyr')
library('reshape2')
library('scales')
#library(ggplot2)
#library(ggthemes)
# 1. 필요한 패키지 불러오기 : 총 5개


# 2. 시간별 인구변화 자료 불러오기
pop = read.csv('C:/Users/daess/Desktop/example_population2.csv')
pop = tbl_df(pop)
head(pop)
str(pop)
# 3. 데이터 전처리
# Q. 데이터가 성별로 나누어져 있을 때, 합하려면?
paste0(pop)

# :: for 문으로 작성해보기

# ::: < 1. 원 code > 
group = group_by(pop, Time)
pop2 = summarize(group, s0=sum(age0to4, age5to9),
                 s10=sum(age10to14, age15to19),
                 s20=sum(age20to24, age25to29),
                 s30=sum(age30to34, age35to39),
                 s40=sum(age40to44, age45to49),
                 s50=sum(age50to54, age55to59),
                 s60=sum(age60to64, age65to69),
                 s70=sum(age70to74, age75to79),
                 s80=sum(age80to84, age85to89),
                 s90=sum(age90to94, age95to99),
                 s100=sum(age100to104, age105to109))

# 저장 제대로 됐는지 확인
head(pop2)

# ::: < 2. for문으로 작성한 code >
# !! 써보세용 !!


# : 4. 각 연령대별 변수를 명목형 변수로
# :: by melt() ftn
# 연령이 변수로 저장되어 있음 -> factor로의 변환 need
pop3 = melt(pop2, id.vas="Time", 
            measure.vars = c("s0","s10","s20","s30","s40","s50","s60","s70","s80","s90","s100"))
colnames(pop3) = c("Time", "Generation", "Population")
head(pop3)
# -> Generation이라는 변수를 만들어서 그 안에 연령을 level로 바꿔버림

# 5. 그래프 그리기
G1 = ggplot(pop3, aes(x=Time, y=Population,
                      color=Generation, fill=Generation)) + geom_area(alpha=0.6) + theme_wsj()
#geom_area() : 영역 그래프를 그림

# 6. Y축 값 변경
# :: y축이 알아보기 어려움

G2 = ggplot(pop3, aes(x=Time, y=Population, color=Generation, fill=Generation)) + geom_area(alpha=0.6) + theme_economist()
G2 + scale_y_continuous(labels = comma)

# 7. 그래프 해석
#1.연령대가 올라갈수록 인구증가율이 높다.
#2.