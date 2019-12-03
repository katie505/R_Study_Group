install.packages('plotly')
library(plotly) #ggplot2에 있는 걸 받아서 interactive graph로 만들어줌
#마우스 움직임에 반응해서 실시간으로 그래프를 조작할 수 있음.
library(ggplot2)
head(mpg)
p = ggplot(data = mpg, mapping = aes(x = displ, y = hwy, col = drv)) + geom_point()
p
ggplotly(p) #그래프를 zoom-in하고 싶으면 드래그, 그래프를 zoom-out하고 싶으면 더블클릭

d = ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + geom_bar()
d #y를 설정하지않으면 프로그램에서 자체적으로 가장 적절하다고 생각하는 y를 대입해서 그래프를 그림

#interactive 시계열 그래프 그리기
if(!require(dygraphs)){install.packages("dygraphs"):library(dygraphs)}
economics = ggplot2::economics #ggplot2안에 있는 economics데이터를 가져오겠다
install.packages('ggplot2')
library(ggplot2)
economics
#프로그램한테 데이터가 시간속성을 가지고 있음을 알려줘야함
library(xts)
#시간에 따른 실업자의 변화 확인
eco = xts(economics$unemploy, order.by = economics$date)
head(eco)
dygraph(eco) %>% dyRangeSelector()
eco_p <- xts(economics$psavert, order.by = economics$date)
dygraph(eco_p) %>% dyRangeSelector()
eco_u <- xts(economics$unemploy, order.by = economics$date)
neweco <- cbind(eco_p, eco_u)
dygraph(neweco) %>% dyRangeSelector() #단위가 달라서 그래프가 이상하게 나옴
neco_u <- xts(economics$unemploy/1000, order.by = economics$date)
nneco <- cbind(eco_p, neco_u)
head(nneco)
dygraph(nneco) %>% dyRangeSelector()
 
p = ggplot2::diamonds
q = ggplot(data = p, mapping = aes(x=cut,fill=clarity)) + geom_bar(position='dodge')
#ggplot2는 무조건 +. 파이프연산자 쓸 수 없음.
q
#postion = 'dodge'를 하면 쓰기 전과 다르게 개별적으로 막대그래프가 그려짐
ggplotly(q)

plot_ly(z=volcano, type="surface") #x,y 알아서 지정해줌
str(volcano)

names(iris)
#facet_wrap, facet_grid차이
p = plot_ly(iris, x = Petal.Length, y=Petal.Width,
            color = Sepal.Length, colors=c("#132B43", "#56B1F7"),
            mode="markers")

test = ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width,
                             color = Species)) + geom_point() + facet_wrap(~Species)
test
plotlyTest = ggplotly(test)
plotlyTest
