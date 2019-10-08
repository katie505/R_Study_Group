z <- c(5,2,-3,8)
w<- z[z*z>8]
w

z*z>8
z[c(T,F,T,T)]

z[z>3] <-0
z

#is.na() 
x<-c(6, 1:2, NA, 12)
x
is.na(x)

#which()
which(x>5) #결과로는 인덱스가 나옴
y<-which(x>5)
length(y) 

#%in% 뒤에 나오는 원소를 포함하고 있는지 
x<-c(3,1,4,1)
x %in% c(2,1,4)

#match() x 원소들을 차례대로 match뒤에 있는 원소들과 비교해서 겹치는 원소가 있으면 match뒤에있는 벡터에서의 원소의 인덱스를 결과로 반환환
x<-c(3,1,2,1)
match(x, c(2,1,4))

####CASTING#####

a=0L #숫자뒤에 L을 붙이면 정수가 됨. 
typeof(a)
a[2] <- 1
a
typeof(a)

m<-matrix(1:10, 5,2)
m
b = m[,-1] #첫번째열을 빼서 결과를 반환
b[5,1]
b = m[,-1, drop=F]
b
class(b)

#matrix -> vector: c()
a = matrix(1:10,5,2) 
a
b = c(a) #1열부터 차례대로.
b

#vector -> factor : as.factor()
a = c('tom', 'jin','jun')
b = as.factor(a)
b

c(b)

#list, data.frame ->vector : unlist()
a=list()
for (i in 1:5) a[[i]] <-i 
a
b<-unlist(a)
b
class(b)

c=data.frame(age = c(17,18,19), home = c('seoul', 'busan', 'jeju'))
c
d = unlist(c)
d
class(d)
class(c$home)

#vector -> matrix : as.matrix()
a = 1:100
b = as.matrix(a)
b

#matrix -> data.frame : as.data.frame()
a = matrix(1:10, 5,2)
a
b = as.data.frame(a)
b
class(b)

#data.frame -> list : unclass()
b 
c = unclass(b)
c
class(c)
rownames(b) = c('first', 'second','third','fourth','fifth')
b
#as.character()
#as.numeric() = as.double()

a <- c(1,2,3,4)
a
b = as.character(a)
b

#####반복문#####
#for문 
for(i in 1:9)
{
  result = i*2
  print(result)
}

#while문 #for문과 다르게 초기값을 설정해줘야함.
i=1
while(i<10)
{
  result = i*2
  print(result)
  i = i+1
}

#repeat문

i=1
repeat{
  result = 2*i
  print(result)
  if(i>=9) break
  i = i+1
}

#next 
for(i in 1:4)
{
  print(i)
  print('cmd1')
  print('cmd2') 
  if(i==3){
    next
  }
  print('cmd3')
}

#break
for(i in 1:4)
{
  print(i)
  print('cmd1')
  print('cmd2') 
  if(i==3){
    break
  }
  print('cmd3')
}
