## ----setup, include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- eval=FALSE, include=TRUE-------------------------------------------------------
## "Protocolo:
## 
##  1. Daniel Felipe Villa Rengifo
## 
##  2. Lenguaje: R
## 
##  3. Tema: método de los   \"k vecinos más cercanos\"
## 
##  4. Fuentes:
##     https://rpubs.com/eropa1981/22869"


## ------------------------------------------------------------------------------------
sink(file = "OUTPUTS.txt")

# vamos a crear la base de datos:
tabla_alumnos<-data.frame(trabajo=c(10,4,6,7,7,6,8,9,2,5,6,5,3,2,2,1,8,9,2,7))

tabla_alumnos$examen<- c(9,5,6,7,8,7,6,9,1,5,7,6,2,1,5,5,9,10,4,6)

# interes en la clase 1 = max 3 = min interes
tabla_alumnos$interes<- c(1,2,1,1,1,2,2,1,3,3,3,2,3,3,2,2,1,1,3,3)

# Observamos la base de datos:
str(tabla_alumnos)

# A priori parece que los alumnos que tuvieron una nota mayor
#veremos cual fue el promedio del examen segun el interes en la clase
write.csv(aggregate(examen ~ interes,data = tabla_alumnos,mean),
          file = "PromExamXInteres.csv", row.names = F)

# Cargamos el paquete class' que contienen la funcion knn
#install.packages("class")
library(class)


# Creamos un vector de eiquetas
# este vector coincidirá con la variable de interes del alumno

# Clasificamos la proxima señal que cuyos datos se almacenan en next_sign
#(dataset entrenamiento)
nuevo_alumno <- data.frame(trabajo=c(2,9),examen=c(3,8))

# modelo de prediciión
prono1 <- knn(train = tabla_alumnos[-c(3)],
              test = nuevo_alumno,
              cl = tabla_alumnos$interes)

#observamos la predicción
print(prono1) ## Resultado: 3 1


## ------------------------------------------------------------------------------------
# normalizamos la tabla de datos
tabla_alumnos.nor<-scale(tabla_alumnos)

# Ahora vemos los datos noramalizados:
str(tabla_alumnos.nor)


# extraemos los atributos de centro y scala de la transformación
attr(tabla_alumnos.nor,"scaled:center")

# atributos de scala de transformación
attr(tabla_alumnos.nor, "scaled:scale")

# Transformamos una nota de examen de 9 para pronostico porterior
# es la  2da columna
nota.t <- scale(9, attr(tabla_alumnos.nor,"scaled:center")[2],
                attr(tabla_alumnos.nor, "scaled:scale")[2])
    
nota.t # valor de nota exam =9 transformado

sink()


## ------------------------------------------------------------------------------------
library(knitr)
purl("")

