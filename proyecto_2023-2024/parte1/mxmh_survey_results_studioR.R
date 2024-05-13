# fecha: 10-05-2024
# nombre: Victor Sanz Arevalo

# Posibles objetivos:
"""
1. Analisis de preferencias musicales y bienestar mental:
Realizar un analisis exploratorio de las variables relacionadas
con las preferencias musicales y el bienestar mental de los 
usuarios, como la frequencia de escuchar diferentes generos 
musicales y los respectivos niveles (0-10) de ansiedad, 
depresion, insomnio y TOC. ?Relacion entre ciertos generos
musicales y los niveles de bienestar mental

2. Efectos de la musica en el bienestar mental: 
Investigar si ay alguna relacion entre la percepcion de los efectos de la 
musica en el bienestar mental y los niveles reales de ansiedad, 
depresion, insomnio y TOC reportados por los encuestados.

3. Prediccion de la cantidad de tiempo dedicado a escuchar musica:
Utilizar variables como la edad, el genero musical favorito y otras 
caracteristicas demograficas. Construir un modelo para predecir cuanto tiempo 
dedica una persona a escuchar musica diariamente.
"""

# Cargar el dataset:
mxmh_survey_results <- read.csv(file.choose(), header = TRUE, sep = ",")

##############################################################################

# Dimensiones:
dim(mxmh_survey_results)

# Atributos:
names(mxmh_survey_results)

# Primeras filas del dataset:
head(mxmh_survey_results)

"""
Variables numericas:
	- "Age"
	- "Hours.per.day"
	- "BPM"
	- "Anxiety"
	- "Depression"
	- "Insomnia"
	- "OCD"
"""

# Resumen estadistico de variables numericas:
summary(mxmh_survey_results[c("Age", "Hours.per.day", 
	"BPM", "Anxiety", "Depression", "Insomnia", "OCD")])

# Grafico de barras para la variables "Primary.streaming.service":
barplot(table(mxmh_survey_results$Primary.streaming.service), 
	main = "Primary Streaming Service")

# Grafico de barras para la variable "Fav.genre":
barplot(table(mxmh_survey_results$Fav.genre), main = "Favorite Genre")

# Correlaciones entre variables numericas:
cor_vars <- mxmh_survey_results[c("Age", "Hours.per.day", "BPM", 
	"Anxiety", "Depression", "Insomnia", "OCD")]
cor(cor_vars)

##############################################################################
