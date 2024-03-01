# nombre: victor sanz arevalo
# fecha: 01-03-2024

HistIBEX<-read.csv(file.choose(),header=TRUE,sep=";")
dim(HistIBEX[1])
head(HistIBEX)
names(HistIBEX)

HistIBEX<-HistIBEX$Ultimo
Historico<-as.numeric(HistIBEX)
is.numeric(Historico)

library(tseries)
library(forecast)

# Tratarlo como serie temporal:

historico<-ts(HistIBEX,start=c(2017,3),frequency=365)

# Representarlo:

plot(historico,main="HistIBEX",col="purple")
length(historico)

# Cargar libreria:

library(dynlm)

AR(1):