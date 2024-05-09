# fecha: 07-05-2024
# nombre: Victor Sanz Arevalo
# --- Recomendador de libros ---

# Cargar datasets:

ratings = read.csv(file.choose(), sep=";")
books = read.csv(file.choose(), sep=";")
users = read.csv(file.choose(), sep=";")

# Mostrar los datos del dataset "books":

install.packages("dplyr")
library(dplyr)

glimpse(books)
dim(books)

# Atributos de los tres datasets:
names(ratings)
names(books)
names(users)

"""
Incluir nueva variable llamada "Category", podra tomar los valores:
	- "Action and Adventures"
	- "Classic"
	- "Detective and Mystery"
	- "Fantasy"
"""

set.seed(1234)
categories = c("Action and Adventures", "Classic", "Detective and Mystery", "Fantasy")
books$Category = sample(categories, nrow(books), replace=TRUE, prob = c(0.25, 0.3, 0.25, 0.20))
books$Category = as.factor(books$Category)
rm(categories)
is.numeric(books$Category)

"""
Aplicar transformacion a los atributos "ISBN" y "User-Id". 
Los IDs empiezan por un numero, R incluira una X delante.
"""

books$ISBN = paste0("Isbn.", books$ISBN)
users$User.ID = paste0("User.", users$User.ID)
ratings$ISBN = paste0("Isbn.", ratings$ISBN)
ratings$User.ID = paste0("User.", ratings$User.ID)

# Conocer los datos del dataset "ratings":

install.packages("ggplot2")
library(ggplot2)

# Realizar el grafico:
ratings %>%
	group_by(Book.Rating) %>%
	summarize(cases = n()) %>%
	ggplot(aes(Book.Rating, cases)) + geom_col() +
	theme_minimal() + scale_x_continuous(breaks = 0:10)

"""
Existen demasiados 0s. Parece que mucha gente no ha realizado una
valoracion del libro. Filtrar los valores que no sean 0:
""" 

ratings = ratings[ratings$Book.Rating!=0, ]

# Volver a mostrar el grafico:
ratings %>%
	group_by(Book.Rating) %>%
	summarize(cases = n()) %>%
	ggplot(aes(Book.Rating, cases)) + geom_col() +
	theme_minimal() + scale_x_continuous(breaks = 0:10) 

# Mostrar cuanto puntua cada persona:
ratings_sum = ratings %>%
	group_by(User.ID) %>%
	count() 

summary(ratings_sum$n)
	