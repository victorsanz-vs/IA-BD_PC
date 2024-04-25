# dataset: titanic_cuantitativo.csv
Titanic<-read.table(file.choose(),header=TRUE,sep=",")

install.packages("strucchange")
library(strucchange)

head(Titanic)
Primera<-which(Titanic$Clase==1)
ST<-which(Titanic$Clase>1)
print(ST)
length(Primera)
Total<-c()
Total<-append(Total,Primera)
Total<-append(Total,ST)

T<-Titanic[Total,]

head(T)
M<-data.frame(Clase=T$Clase,Edad=T$Edad,Precio=T$Precio)
dim(M)
# Test de Chow:
sctest(M$Precio~M$Edad,type="Chow",point=216)
# [p-value = 4.051e-08]

