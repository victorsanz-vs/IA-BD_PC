# fecha: 10-05-2024
# nombre: Victor Sanz Arevalo

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
