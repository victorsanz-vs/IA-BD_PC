# Instalamos paquete

install.packages("tseries")

library(tseries)


install.packages("forecast")

library(forecast)

install.packages("astsa")

library(astsa)



# Cargamos datos

Datos<-scan('https://www.diegocalvo.es/wp-content/uploads/2016/09/datos-serie-temporal.txt')
# Visualizamos
Datos
# Convertimos a serie de tiempo

# Visualizamos
print(tsData)
# Representamos
Datos<-ts(Datos, start = c(1966,1), frequency =12)
tsData<-ts(log(Datos), start = c(1966,1), frequency =12)

plot(tsData)


# Estudiamos si es una serie estacionaria con el test DF
adf.test(tsData,alternative="stationary")



# Diferenciamos

datadiff<-diff(tsData)
par(mfrow=c(1,3))
plot(Datos,main="Original",col="blue")
plot(tsData,main="Logaritmos",col="blue")
plot(datadiff,main="1 º Diferencia",col="blue")
# Veamos si es estacionaria la 1 º diferncia

adf.test(datadiff,alternative="stationary")
# El test D.F asegura que esestacinaria despues de efectuar la primera diferencia







# Estudiamos las funciones de acf y pacf



par(mfrow=c(2,1))


acf(ts(datadiff,frequency=1),main="Acf 1º diferencia")
pacf(ts(datadiff,frequency=1),main="Pacf 1 º diferencia")



# Probamos con un modelo ARIMA(3,5)
modelo<-arima(tsData,order=c(3,0,5))
modelo
tsdiag(modelo)
Box.test(residuals(modelo),type="Ljung-Box")

# Pronosticos
pronostico<-forecast(modelo, h=5)
names(pronostico)
plot(pronostico)
names(pronostico)
pronostico$mean

pronosticos<-exp(pronostico$mean)
pronosticos
plot(pronosticos)












