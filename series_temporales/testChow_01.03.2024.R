# nombre: victor sanz arevalo
# fecha: 01-03-2024

tTitanic<-read.csv(file.choose(),header=TRUE,sep=",")
head(tTitanic)
dim(tTitanic)

genero<-c("Hombres","Mujeres")
nombre<-c("Sobrevive","Muere")
