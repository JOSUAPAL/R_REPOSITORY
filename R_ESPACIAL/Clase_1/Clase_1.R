library(sf)
library(tidyverse)
library(rworldxtra)

#base de datos es un spatialPolygonsdataframe (datos vectoriales)
data("countriesHigh")

#transformamos nuestro poligono a una tabla con st_as_sf

Mundo<-st_as_sf(countriesHigh)

ggplot()+geom_sf(data=Mundo)

#solo me sale mapa del mundo sin llenado

#le pongo relleno PRIMERO CONSULTO EL CONTENIDO DEL SHAPEFILE DE CAMPOS
colnames(Mundo)

#seleccionamos region que son regiones
ggplot()+geom_sf(data=Mundo, aes(fill=REGION))

#puedo hacer filtrado de datos. Voy a hacer un filtro con africa

Africa<-Mundo %>% dplyr::filter(continent=="Africa")

#AHORA PUEDO PLOTEAR SOBRE AFRICA RELLENAR EL POP_EST POBALCIÓN ESTIMADA
ggplot()+geom_sf(data=Africa, aes(fill=POP_EST))

##OTRA FORMA QUE PODEMOS HACER ES MEDIANTE VALORES MAYORES O MENORER PARA VARIABLES NUMÉRICAS

PIB_Alto<- Mundo %>% dplyr::filter(GDP_MD_EST >=median(Mundo$GDP_MD_EST))
ggplot()+geom_sf(data=PIB_Alto, aes(fill=GDP_MD_EST))

##MODIFICAR Y GENERAR OTRAS BASES DE DATOS

Africa<-Africa%>% mutate(Poblacion_mill=POP_EST/1000000) #GENERO UNA NUEVA VARIALBE poblacion_mill que está en millones
ggplot()+geom_sf(data=Africa, aes(fill=Poblacion_mill)) 

#puedo cambiar el la escala de colores para que se vea, algunos son continuos y otros discretos
ggplot()+geom_sf(data=Africa, aes(fill=Poblacion_mill))+scale_fill_viridis_c()

#minuto 22:50 clase 1

