# nombre: victor sanz arevalo
# fecha: 01-02-2024

install.packages("tseries")
install.packages("forecast")

Ibex35<-read.csv(file=file.choose(),header=TRUE,sep=",")
head(Ibex35)

Ibex35<-Ibex35$Ultimo
Ibex<-as.numeric(Ibex35)
is.numeric(Ibex)

library(tseries)
library(forecast)

# Tratarlo como serie temporal:

IBEX<-ts(Ibex35,start=c(2019,3),frequency=52)

# Representarlo:

plot(IBEX,main="Ibex35",col="blue")
length(IBEX)

# Instalar paquete para efectuar modelos AR:

install.packages("dynlm")

# Cargar libreria:

library(dynlm)

# Utlizar solo un AR(1):

modelo1<-dynlm(Ibex~L(Ibex),data=Ibex)
summary(modelo1)

# Probar con un AR(2):
# Se observa que el 2º retardo no es significativo.
# Estudiar los retardos 1º y 3º, y se observa cierta mejoria.
# No hay AR mejores.

modelo3<-dynlm(Ibex~L(Ibex,c(1,3)),data=Ibex)
summary(modelo3)

# Calcular tendencia y estacionalidad:

modelo4<-dynlm(Ibex~trend(Ibex)+L(Ibex,c(1,3)),data=Ibex)
summary(modelo4)

# Al introducir la tendencia no se observa mejoria:
# Conviene eliminarla. Estudiar la componente estacional

modelo6<-dynlm(Ibex~trend(Ibex)+season(Ibex)+L(Ibex,c(1,3)),data=Ibex)
summary(modelo6)

# Se observa que algunas pocas semanas ejercen
# estacionalidad pero empeorando el modelo.
# En este caso, no debe tenerse encuenta ni
# la tendencia ni la componente estacional
# Escoger el modelo3.

summary(modelo3)

# Buscar modelo ARIMA(p,q) para poder efectuar pronosticos
# Sobre la serie temporal. 
# Estudiar si la serie es estacionaria.
# Para ello ensayar el test df.

adf.test(Ibex,alternative="stationary")

# H0: No estacionaria.
# H1: Estacionaria.
# El p-value = 0.0.4172>0.05 => H0.
# No es estacionaria.
# Existen dos alternativas:
# 	1) Suavizar la serie con logaritmos.
#	2) Diferenciar la serie hasta conseguir estacionariedad.
# Alternativa 1:

Ibexlog<-log(Ibex)
plot(Ibexlog,main="Serie logaritmos",col="blue")

# Aplicar el test df a la serie de logaritmos.
# Con un p-value = 0.4172>=0.05 => Aceptar H0. 
# Por lo que la serie logaritmica NO es estacionaria.

# Alternativa 2: Diferenciar.
# 1ª Diferencia:

diferenciaprimera<-diff(Ibex)

# Representarlo:

plot(diferenciaprimera,main="Serie Primera Diferencia",col="blue")

# Aplicar el test df:

adf.test(diferenciaprimera,alternative="stationary")

# Con un p-value = 0.01 => Aceptar H1.
# La serie diferenciada ya es estacionaria.
# Estimar los p y q del proceso ARIMA.

# Para ello representar las funciones acf pacf:

par(mfrow=c(1,2))
acf(ts(diferenciaprimera,frequency=1))
pacf(ts(diferenciaprimera,frequency=1))

# Plantear el modelo ARIMA:

AR<-arima(Ibex,order=c(0,1,1))
print(AR)
tsdiag(AR)

# Test L-B para validar el modelo:

Box.test(residuals(AR),type="Ljung-Box")

# El p-value = 0.9247 >= 0.05 => Se acepta el modelo.

# Errores:

error<-residuals(AR)
plot(density(error))

# Pronosticos:

pronosticos<-forecast(AR, h=4)
print(pronosticos)
plot(pronosticos)






















