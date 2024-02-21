# Red Neuronal
# fecha: 21-02-2024
# nombre: Victor Sanz

"
Se define la funcion Escalon o de Heaviside en
el intervalo (a,b) como:
	f(z)=1 si z∈(a,b)
	f(z)=0
En otro caso se denota H(a,b).
Ejemplo:
Si a=1 y b=3 se tiene que H(2)=1 pues 2∈(1,3).
Sin embargo H(4)=0 pues no se encuentra en el intervalo (1,3).
Tomar una muestra aleatoria de tamagno 100 eb el intervalo (1,3).
Para cada valor de la muestra z calcular:
	X1(z)=H(1,3)(z)
	X2(z)=H(3,5)(z)
	X3(z)=H(5,7)(z)
	X4(z)=H(7,9)(z)
Pesos:
	w0=0
	w1=0.15
	w2=0.35
	w3=0.35
	w4=0.15
Calcular:
	X(z)=wo+w1*X1(z)+w2*X2(z)+w3*X3(z)+w4*X4(z)
Sea:
	Y=1	si X>0.5
	Y=-1	si X>=0.5
Admitimos que la neurona se activa si Y=1 y no lo hace cuando Y=-1. 
Evaluar el numero de veces que se activa la neurona de las 100 muestreadas 
y calcular % de activacion.
"

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

