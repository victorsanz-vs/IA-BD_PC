# fecha: 09-05-2024
# nombre: Victor Sanz Arevalo
# url: https://rstudio-pubs-static.s3.amazonaws.com/432515_2ec5e23a0c5c4730bf30c12d26537818.html
# --- Aplicacion1 ---

# Datos simulados sobre valoraciones de 10 items por 3 usuarios:
usuario_a <- c(4, 4, 4, 3, 3, 5, 5, 2, 3, 5)
usuario_b <- c(2, 2, 2, 1, 2, 4, 3, 2, 2, 4)
usuario_c <- c(1, 2, 3, 3, 1, 2, 1, 3, 2, 2)

items = c("i01", "i02", "i03", "i04", "i05", "i06", "i07", "i08", "i09", "i10")
item = factor(rep(items, 3), ordered = TRUE, levels = items)
m <- matrix(c(usuario_a, usuario_b, usuario_c), ncol = 10, byrow = TRUE,
	dimnames = list(user = paste("u", 1:3, sep=''), item = items))
print(m)

"""
La matriz de valoraciones 'm' la reconocemos como tal en R a traves 
del comando 'as(, "realRatingMatrix")'.
"""

# Objeto realRatingMatrix:
rr = as(m, "realRatingMatrix")
getRatingMatrix(rr)

"""
Considerar la necesidad en ocasiones de estandarizar los valores, 
para corregir por el efecto de escala que proviene del diferente nivel 
de exigencia de los usuarios en sus valoraciones. Hay dos metodos para 
normalizar: restar la media, y restar la media y dividir por la 
desviacion tipica. Estas normalizaciones se realizan por usuario (filas).
"""

# Estandarizacion de valores:
rc <- normalize(rr, method = "center")
rz <- normalize(rr, method = "Z-score")

# Integracion en un data.frame:
r.df = as(rr, "data.frame"); r.df

# Representacion de una matriz de valoraciones mediante lineas:
library("ggplot2")
ggplot(r.df, aes(x = as.factor(item), y = rating, colour = user)) +
	geom_path(aes(group = user)) +
	geom_point() +
	labs(x = "item") +
	theme_bw() +
	theme(legend.position = "bottom")

"""
Representacion de una matriz mediante graficos tridimensionales
utilizando grados de intensidad de color para las valoraciones:
"""
image(rr, main = "Raw Rating First")
image(rc, main = "Raw Rating Second")
image(rz, main = "Raw Rating Third")

# Medidas de distancia para valoraciones en una escala continua:
# Calculo de distancias:
mc = as(rc, "matrix")
mz = as(rz, "matrix")

# Euclidea:
dist(m, method = "euclidean")
dist(mc, method = "euclidean")
dist(mz, method = "euclidean")

# Manhattan:
dist(m, method = "manhattan")
dist(mc, method = "manhattan")
dist(mz, method = "manhattan")

# Correlacion:
cor(t(m), method = "pearson")
cor(t(m), method = "kendall")

# Correlacion jacknife:
# install.packages("bootstrap")
library(bootstrap)
mm = m
xdata <- mm[-3, ]
theta <- function(i, xdata){
	cor(xdata[1, i], xdata[2, i])
}
results <- jackknife(1:dim(xdata)[2], theta, xdata); results; 

min(abs(results$jack.values)); mean(results$jack.values)

xdata <- mm[-2, ]
results <- jackknife(1:dim(xdata)[2], theta, xdata) #; results; 
min(abs(results$jack.values)); mean(results$jack.values)

xdata <- mm[-1, ]
results <- jackknife(1:dim(xdata)[2], theta, xdata) #; results; 
min(abs(results$jack.values)); mean(results$jack.values)

# Distancia coseno:
mm = m
mm = mz
coseno = function(x,y){
	result = x%*%y/sqrt((x%*%x)*(y%*%y))
	return(as.numeric(result))
}
coseno(mm[1, ], mm[2, ])
coseno(mm[1, ], mm[3, ])
coseno(mm[2, ], mm[3, ])

"""
Las principales medidas de distancia para valoraciones en una 
escala binaria son las siguientes:
"""
set.seed(3456)
N = 10
megusta_a = rbinom(N, 1, 0.2)
megusta_b = rbinom(N, 1, 0.7)
megusta = rbind(megusta_a, megusta_b)

# install.packages("ade4")
library(ade4)
table(megusta[1, ], megusta[2, ])

binary.dist = function(mdatos){
	# Matriz de datos en la que las filas son los usuarios:
	x = table(mdatos[1, ], mdatos[2, ])
	a = x[2, 2]
	b = x[2, 1]
	c = x[1, 2]
	d = x[1, 1]
	jaccard = round((b+c) / (a+b+c), 4)
	smc = round((b+c) / sum(x), 4)
	return(list(jaccard = jaccard, smc = smc))
}
binary.dist(megusta)
