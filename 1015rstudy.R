#통계함수
a <- c(2,7,5,3,1,4,6)
sum(a)
prod(a) #곱
max(a)
min(a)
diff(a) #앞 원소와의 차이
which.max(a)
which.min(a) #제일 작은 원소의 인덱스 추출
range(a)
mean(a)
median(a)
sd(a)
var(a)
quantile(a)
quantile(a, 0.75)

#수학연산
log(a) #자연로그
log(a, base=2)
exp(a)
sqrt(a)
abs(a)
round(sqrt(a), 2) #소수점둘째자리까지 반올림
floor(sqrt(a)) #버림
ceiling(sqrt(a)) #가장 가까운 큰 자연수.
cumsum(a)
cumprod(a)
cummin(a)
cummax(a)

#집합
b <- c(1,2,10)
union(a,b)
intersect(a,b)
setdiff(a,b) #차집합합
is.element(a,b)
setequal(a,b) #a와 b가 같냐
union("banana is mine", "apple is mine")#문자열도 가능
intersect(c("banana", "is", "mine"), c("apple", "is", "mine"))
c <- c("banana", "is", "mine")
d <- c("apple", "is", "mine")
intersect(c,d)

min(c(2,8,3), c(3,4,5), c(5,2,9))
pmin(c(2,8,3), c(3,4,5), c(5,2,9)) #행렬로 만들어서 행별로 가장 작은 값들 추출
z <- matrix(c(1,5,6,2,3,2,0,2,5), ncol = 3)
z
min(z[,1], z[,2], z[,3])

#확률분포
#dist dnorm pnorm qnorm rnorm : 정규분포 분포, pdf, cdf, 분위수, 난수생성
#(a) 정답이 하나도 없을 확률
dbinom(0, 20, 1/5)
#(b) 8개 이상 맞출 확률ㅂ
1 - pbinom(7, 20, 1/5)
#(c) 맞춘 게 4개에서 6개 사이
pbinom(6, 20, 1/5) - pbinom(3, 20, 1/5)

#P(Z<1.9 OR Z>2.1)
pnorm(-1.9, 0, 1) + 1-pnorm(2.1, 0, 1)

x <- c(12, 5, 3, 9)
sort(x)
sort(x, decreasing = T)
#sort(x)한다고 해서 x의 값이 바뀌는 것은 아님
rev(x) #x 내부 순서를 반대로
rank(x) #원소의 인덱스 자리에 순위를 적어줌
rank(-x)
order(x) # 원소를 순서대로 나열해서 결과로 추출하는데, 원소를 그대로가 아닌 원소의 인덱스를 추출함.
a <- matrix(c(1,2,3,4), ncol = 2, byrow=TRUE)
b <- matrix(c(1,0,-1,1), ncol = 2)
 
a%*%b #행렬곱

a <- matrix(c(1,1,-1,1), nrow=2, ncol = 2)
b <- c(2,4)
solve(a,b)
c = solve(a)
a %*% c
t(a)
det(a)
eigen(a)
diag(a)
diag(3)
diag(c(1,2,3))
diag(10,3,4)
svd(a)

m<-matrix(c(1:9), nrow=3, byrow=TRUE)
m
sweep(m, 1, c(1,4,7), "+")
s<-matrix(1:12, 3,4)
s
sweep(s, 2, colMeans(s)) #각원소별로 열평균으로부터의 편차

nchar("South Pole")
paste("North","Pole")
paste("North","Pole",sep="-")
substring("Equator",3,5) #substr까지만 써줘도 됨.
strsplit("6-16-2011",split="-")
tolower("Hello")
toupper("Hello")
str_rim("  Hello World!  ",side=left)
#substr 이용하여 Today is Monday를 Tueday로 바꾸기
string_1 = "Today is Monday"
substr(string_1, 10, 12) <- "Tue"
string_1

#문자열 찾기 (기본)
grep("Pole",c("Equator","North Pole","South Pole"), fixed=TRUE)
grepl("Pole",c("Equator","North Pole","South Pole"))
regexpr("Pole",c("Equator","North Pole Pole","South Pole")) # equator에는 pole이 없으므로 -1, 나머지는 7번째 자리부터 pole존재. 밑에 결과값은 글자 길이.
gregexpr("Pole",c("Equator","North Pole Pole","South Pole")) # reg결과값을 각 단어마다 나오도록. 하나에 같은 단어가 두개 있으면 regexpr과는 다르게 두개의 단어의 시작 위치가 모두 반환됨.
regexec("Pole",c("Equator","North Pole","South Pole")) #grecexpr과 같은 결과값이 나옴

regexpr("uat","Equator")
gregexpr("iss","Mississippi")
#옵션 : value(인덱스가 아닌 문자열 그 자체가 출력됨), invert(찾으려는 단어가 없는 문자열의 인덱스 추출), ignore.case(대소문자 구분안하고 찾는다, 만약 이 옵션이 없다면 대소문자 구분해줘야함), fixed

#문자열 찾기 (패키지)
install.packages("stringr")
library(stringr)

fruit <- c("apple", "banana", "cherry")
str_count(fruit, "a")
str_detect(fruit, "a")
str_locate(fruit, "a")
str_locate_all(fruit, "a")

people <- c("rorori", "emilia", "youna")
str_extract(people, "o(\\D)")   #\\D는 non-digit character를 의미합니다.
str_extract_all(people, "o(\\D)")
str_match(people, "o(\\D)(\\D)")
str_match_all(people, "o(\\D)")

#문자열 찾아서 바꾸기
fruits <- c("one apple", "two pears", "three bananas")
sub("[aeiou]", "-", fruits)
str_replace(fruits, "[aeiou]", "-")
gsub("[aeiou]", "-", fruits)
str_replace_all(fruits, "[aeiou]", "-")
