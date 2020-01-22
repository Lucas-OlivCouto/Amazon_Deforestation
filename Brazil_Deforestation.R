#Libraries
require(dplyr)
require(sf)
require(ggthemes)
require(ggplot2) 
require(ggrepel)
theme_set(theme_bw())

#Setting unique paths
Andrea <- '/Users/andreaquevedo/Documents/Georgetown/Fall_2019/Data_Visualization_for_Data_Science/Brazil_Deforestation/'
plots<-'/Users/andreaquevedo/Documents/Georgetown/Fall_2019/Data_Visualization_for_Data_Science/Brazil_Deforestation'



#### LOADING SHAPEFILES ####

### PRODES ###
PRODES_path<- paste(Andrea,"PRODES_deforestation/", sep="")
PRODES_shape <-"PRODES_deforestation.shp"
PRODES_file <- paste(PRODES_path, PRODES_shape, sep="")
PRODES_shp <- read_sf(PRODES_file)

### BRAZIL STATES ###
BRM_path<- paste(Andrea,"Brazil/", sep="")
BRM_shape <-"Brazil_Admin_1.shp"
BRM_file <- paste(BRM_path, BRM_shape, sep="")
BRM_shp <- read_sf(BRM_file)



#### MODIFYING SHAPEFILES ####

##  DEFORESTATION 2015 ## 
deforestation_15<- PRODES_shp%>% 
  filter(ano %in% c(2015))

#The legal Amazon comprises the states of 
#Acre, Amapá, Pará, Amazonas, Rondonia, Roraima, and part of Mato Grosso, Tocantins, and Maranhão.
legal_amazon_states <- c("Acre","Amapá","Pará", "Amazonas","Rondônia", "Mato Grosso","Tocantins","Maranhão", "Roraima")

amazon_states<- BRM_shp%>% 
  #Keeping only states comprising Amazon forest 
  filter(NAME_1 %in% legal_amazon_states)



#### MAPS ####

## States Covering Legal Amazon ##
am_state_map<- ggplot() +
  geom_sf(data = amazon_states, fill = '#009E73')+
  geom_sf(data = BRM_shp, fill = NA)+
  coord_sf(crs= "+proj=longlat +datum=WGS84")+
  labs(title = "States Covering the Legal Amazon")+
  theme_map()+
  theme(plot.title = element_text(size=14, face="bold"))

print(am_state_map)


## Deforestation 2015 Map ##
def15_map<- ggplot() +
  geom_sf(data = amazon_states, fill = '#009E73')+
  geom_sf(data = deforestation_15, color= '#D55E00')+
  geom_sf(data = BRM_shp, fill = NA)+
  coord_sf(crs= "+proj=longlat +datum=WGS84")+
  labs(title = "Deforestation in the States covering the Legal Amazon",
       subtitle = "2015",
       caption = "Source: PRODES")+
  theme_map()+
  theme(plot.title = element_text(size=14, face="bold"))

print(def15_map)




