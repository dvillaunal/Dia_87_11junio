```{r, eval=FALSE, include=TRUE}
"Protocolo:
 
 1. Daniel Felipe Villa Rengifo
 
 2. Lenguaje: R
 
 3. Tema: método de los   \"k vecinos más cercanos\"
 
 4. Fuentes:  
    https://rpubs.com/eropa1981/22869"
```

# k-NN (k-Nearest Neighbour Classification) OR K vecinos más cercanos

El algoritmo `k-NN` reconoce patrones en los datos sin un aprendizaje específico, simplemente midiendo la distancia entre grupos de datos. Se trata de uno de los algoritmos más simples y robustos de aprendizaje automático.

En realidad el algoritmo puede usarse tanto para clasificar como para pronosticar mediante regresión, __pero aquí veremos solo la forma de clasificación__.

Para usarlos necesitamos cargar el paquete `class` y usar la función `knn()` que realiza la __clasificación__.

la idea implicita que se tiene es que a partir de un conjunto de datos de entrenamiento se pueda deducir un criterio de agrupamiento de los datos.

> Nota: Es un algoritmo muy simple de implementar y de entrenar, pero tienen una carga computacional elevada y no es apropiado cuando se tienen muchos grados de libertad.

## Consideraciones Previas

+ __¿Como se calcula la similitud con respecto a la distancia?__

debemos tener en mente que las distancias entre variables deben ser comparables.
Si usamos un rango de medida en una variable y otro muy distinto en otra, las distancias no están normalizadas y estaremos comparando peras con manzanas.

__Para realizar un análisis con__ `knn` __tenemos siempre de normalizar los datos__, re-escalar todas las variables para que las distancias sean equiparables. Este proceso se suele llamar: _estandarización de los datos_.

+ Otro importante asunto es que hay que eliminar los NA de los datos, pues afectan a los cálculos de distancia.

+ Por último, como se indicó antes, este modelo es válido solo para casos con pocas dimensiones en los datos, pocos grados de libertad. Cuando se incrementa la dimensión espacial de los datos, la complejidad y el cálculo se hacen inviables.

### Ejemplo

Vamos a hacer un ejemplo sencillo de clasificación con unos datos inventados: Imaginemos que un profesor ha anotado durante el curso los siguientes datos de los alumnos:

+ nota del trabajo de clase del primer trimestre (del 1 al 10). 

+ nota del examen 1º evaluación (del 1 al 10).

+ interés mostrado en clase por cada alumno al final del curso:
  
  1. máximo
  2. medio
  3. mínimo

Con estas variables creamos la base:

> Nota: Con la función sink guardamos todos los Outputs no graficos, así podra ver todo lo ejecutado, y así en caso de que no corra el replit por cargar librerias vera todo lo realizado, que no se puede guardar como .csv o data.frame-matrix a .txt

```{r}
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
```

# Estandarización

Para otros casos en los que las variables no tengan la misma escala, es preferible para mejorar el modelo normalizar las columnas de datos numéricos.

Esto puede hacerse con muchas funciones predefinidas como por ejemplo la función `scale()` o `data.Normalization()` esta del paquete `clusterSim`.

> Nota: Hay que tener en cuenta que cuando normalizamos los valores de hechos que pasamos a `predict()`, deben ser normalizados con el mismo algoritmo.

```{r}
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
```
