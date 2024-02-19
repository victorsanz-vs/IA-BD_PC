install.packages("tm",dependencies=TRUE)
library(tm)

# Cargamos EL QUIJOTE

source<-URISource("http://www.gutenberg.org/cache/epub/2000/pg2000.txt",encoding="UTF-8")
quijote<-Corpus(source)

# Cargar y manipular un PDF

source<-URISource("http://cran.r-project.org/web/packages/tm/vignettes/tm.pdf")
c<-Corpus(source, readerControl=list(reader=readPDF))

# Introducimos textos a mano

c1<-c("Un ejemplo de documento de texto", "Un segundo ejemplo de documento") 
c2<-c("Usando el paquete tm", "Ejemplo de uso de corpus en tm","Minería de texto con tm")
# Convertimos a corpus el 1 º texto
corpus1<-Corpus(VectorSource(c1))
# Accedo al primer documento del corpus 1
corpus1[[1]]
# Cargo el 2 documento en formato carpus
 corpus2<-Corpus(VectorSource(c2))
# Unimos a concatenar los dos corpus en un tercero
 corpus3<-c(corpus1, corpus2)

corpus3

# Accedo a lista de componentes en el corpus3
corpus3[2:3]
# Accedo a uno de los documentos

c1[[2]]

# Tareas habituales en Mineria de Texto
# Cargamos texto
text<-c("En un lugar de la Mancha de cuyo nombre no quiero acordarme...",
"Miguel de Cervantes Saavedra (1547-1616)")
# Le damos estructura
corpus<-Corpus(VectorSource(text))

# Convertimos a minusculas con la funcion tm_map

corpus<-tm_map(corpus, tolower)
# Mostramos contenido
corpus[[2]]$content
corpus[[1]]$content

# Eliminacion de los simbolos de puntuacion

corpus<-tm_map(corpus, removePunctuation)

corpus[[2]]$content
corpus[[1]]$content

# Eliminacion de numeros

corpus<-tm_map(corpus, removeNumbers)
corpus[[2]]$content

# Eliminamos las palabras sin significado

corpus<-tm_map(corpus, removeWords, stopwords("spanish"))

corpus[[1]]$content

corpus[[2]]$content

# Construccion de matrices de documentos

docs<-c("primer documento al principio", "segundo documento tras el primer
documento", "tercer documento tras el segundo documento", "cuarto documento")
 corpus<-Corpus(VectorSource(docs))
 tdm<-TermDocumentMatrix(corpus)

# Inspecionamos e interpretamos las salidasd de la funcion inspect
inspect(tdm)


# Inspecionamos si un termino esta o no en documento
# Sin tener en cuenta el numero de veces que aparece

# Carga de documentos

docs<-c("primer documento al principio", "segundo documento tras el primer
documento", "tercer documento tras el segundo documento", "cuarto documento")

# Estructuras los documentos como corpus

 corpus<-Corpus(VectorSource(docs))

# Matriz de terminos-documentos

 tdmBin<-TermDocumentMatrix(corpus, control=list(weighting=weightBin))

 inspect(tdmBin) 

# Matriz de terminos-documentos indicando la frecuencia relativa de cada termino en cada documento

 tdmTf<-TermDocumentMatrix(corpus, control=list(weighting=weightTfIdf))

 inspect(tdmTf) 

# Matriz de terminos -documentos en frecuancias absolutas

 tdmTfA<-TermDocumentMatrix(corpus)

 inspect(tdmTfA) 
# Filtrar por longitud de las palabras

tdm<-TermDocumentMatrix(corpus, control=list(wordLengths=c(3,6)))
inspect(tdm)

# CARGAMOS LAS CARPETA ACQ Y CRUDE

acq<-Corpus(DirSource(directory="C:\\Users\\Admin\\Desktop\\Mineria de texto\\acq", encoding = "UTF-8", pattern= "*.txt"))
crude<-Corpus(DirSource(directory="C:\\Users\\Admin\\Desktop\\Mineria de texto\\crude", encoding = "UTF-8",pattern = "*.txt"))

# Unimos los archivos de ambas carpetas
corpus<-c(acq,crude)

# Quitamos mayusculas
acq <- tm_map(acq, tolower)
crude <- tm_map(crude, tolower)
# Quitamos stopwords
acq <- tm_map(acq, removeWords, stopwords("english"))
crude <- tm_map(crude, removeWords, stopwords("english"))

# Eliminamos simbolos de puntuacion
acq <- tm_map(acq, removePunctuation)
crude <- tm_map(crude, removePunctuation)
# Eliminamos numeros
acq <- tm_map(acq, removeNumbers)
crude <- tm_map(crude, removeNumbers)

# Unir ambos

 corpus<-c(acq,crude)
corpus<-Corpus(VectorSource(corpus))


tdm<-TermDocumentMatrix(corpus, control=list(wordLengths=c(4,8)))
inspect(tdm)



corpus[[4]]$content

# En tgerminos de frecuencia relativa

 tdmTf<-TermDocumentMatrix(corpus, control=list(weighting=weightTfIdf))

inspect(tdmTf)




