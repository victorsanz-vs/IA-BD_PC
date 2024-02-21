# Red Neuronal
# fecha: 21-02-2024
# nombre: Victor Sanz

# Funcion Heaviside:
H<-function(a,b,z){
	y<-0
	if(z>a & z<b){
		y<-1}
	return(y)}

# Funcion de entradas:
X<-function(a1,a2,a3,a4,a5,z){
	y<-0.15*H(a1,a2,z)+0.35*H(a2,a3,z)+0.35*H(a3,a4,z)+0.15*H(a4,a5,z)
	return(y)}

# Funcion de activacion de la neurona:
Y<-function(X){
	y<--1
	if(X>0.5){
		y<-1}
	return(y)}

# Tomo muestra:
Z<-rnorm(100,5,1)
print(Z)
a1<-1
a2<-3
a3<-5
a4<-7
a5<-9
Q<-c()
i<-1
while(i<=100){
	Q<-append(Q,X(a1,a2,a3,a4,a5,Z[[i]]))
	i<-i+1}
i<-1
R<-c()
while(i<=100){
	R<-append(R,Y(Q[[i]]))
	i<-i+1}
print(R)

