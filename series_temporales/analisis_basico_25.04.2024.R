# fichero: gas6677.dat
"""
Contiene datos mensuales del consumo de gasolina en Espagna
(enero, 1966-agosto, 1977).
"""

install.packages("tseries")
library(tseries)

gas=scan('http://verso.mat.uam.es/~joser.berrendero/datos/gas6677.dat')
plot(gas)

# El grafico no es el mas apropiado para describir una serie temporal.

gas.ts=ts(gas,start=c(1966,1),frequency=12)

# "frequency" se utiliza para indicar la periodicidad de la serie.
# "start" indica la fecha de la primera observacion.

print(gas.ts)
plot(gas.ts)

# El resultado depende de las caracteristicas que se ha definido para la serie.
# Comparacion de la distribucion del consumo de gasolina para cada mes:
boxplot(gas.ts~cycle(gas.ts))

# "cycle" determina la unidad de tiempo a la que pertenece la observacion.
# Diagrama de cajas para cada mes del año:
cycle(gas.ts)