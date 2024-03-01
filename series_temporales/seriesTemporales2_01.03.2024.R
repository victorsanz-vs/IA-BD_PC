install.packages("tseries")
install.packages("forecast")

Ibex35<-read.csv(file=file.choose(),header=TRUE,sep=",")

head(Ibex35)

write.csv(Ibex35,file="C:\\Users\\Admin\\Desktop\\Ibex35.csv")

Ibex35<-read.csv(file="C:\\Users\\Admin\\Desktop\\Ibex35.csv")


Ibex35<-Ibex35$Ultimo
Ibex<-as.numeric(Ibex35$Ultimo)
is.numeric(Ibex)

library(tseries)
library(forecast)
# Lo tratamos como tserie
Ibex<-ts(Ibex35,start=c(2019,3),frequency=52)

# Lo representamos
plot(Ibex,main="Ibex35",col="blue")

length(Ibex)


# Instalamos paquete para efectuar modelos AR
install.packages("dynlm")
# Libreria
library(dynlm)
# Utlizo solo un AR(1)
modelo1<-dynlm(Ibex~L(Ibex),data=Ibex)
summary(modelo1)
# Veamos un AR(2)
# Se observa que el 2 º retardo no es significativo
# Estudiamos los retardos 1 y 3 y se observa cierta mejoria
# No encontramos AR mejores

modelo3<-dynlm(Ibex~L(Ibex,c(1,3)),data=Ibex)
summary(modelo3)

# Podemos calcular tendencia y estacionalidad

modelo4<-dynlm(Ibex~trend(Ibex)+L(Ibex,c(1,3)),data=Ibex)
summary(modelo4)

# Al introducir la tendencia no se mejora
# Por tanto conviene eliminarla

# Estudiamos la componente estacional

modelo6<-dynlm(Ibex~trend(Ibex)+season(Ibex)+L(Ibex,c(1,3)),data=Ibex)
summary(modelo6)

# Se observa que algunas pocas semanas ejercen
# estacionalidad pero empeorando el modelo
# Por tanto en este caso no debe tenerse encuenta ni
# la tendencia ni la componentge estacional
# Por lo que nos quedamos con el 3 º modelo

summary(modelo3)
# Buscamos modelo Arima(p,q) para poder efectuar pronosticos
#  Sobre la serie temporal 

# Estudiamos si la serie estacionaria
# Para ello ensayamos el test df

adf.test(Ibex,alternative="stationary")
# En este test Ho: No estacionaria
# Frente H1 : Estacionaria
# El p'-vañlor=0,4729>0.05=> Ho
# Deducimos que no es estacionaria
# Tenemos 2 alternativas
#1) Suavizar la serie con logaritmos
#2) Diferenciar la serie hasta consehuir estacionariedad
# 1) Alternativa
Ibexlog<-log(Ibex)
plot(Ibexlog,main="Serie logaritmos",col="blue")
# Aplicamos el test df a la serie de logaritmos
# Con un p-valor=0.4574>=0.05=> Aceptar Ho. Por lo 
# que la seri logaritmica no es estacionaria
# 2) Alternativa. Diferenciar
# 1º diferencia
diferenciaprimera<-diff(Ibex)
# La representamos

plot(diferenciaprimera,main="Serie primera diferencia",col="blue")
# Aplico el test de df

adf.test(diferenciaprimera,alternative="stationary")

# Con un p-valor=0.01 se asegura que aceptamos
# H1 por lo que ja serie diferenciada ya es estacionaria

# Estimacion de los p,q del proceso Arima

# Para ello representamos las funciones acf pacf
par(mfrow=c(1,2))
acf(ts(diferenciaprimera,frequency=1))
pacf(ts(diferenciaprimera,frequency=1))

# Planteamos el modelo arima

AR<-arima(Ibex,order=c(0,1,1))
AR
tsdiag(AR)

# Test L-B para validar el modelo

Box.test(residuals(AR),type="Ljung-Box")

# El p-valor =0.9261>=0.05=> Se acepta el modelo

# Errores
error<-residuals(AR)
plot(density(error))

# Pronosticos
pronosticos<-forecast(AR, h=4)
pronosticos
plot(pronosticos)






















