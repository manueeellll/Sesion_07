install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

#conectamos a la base

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

#mostramos tablas de la BD
dbListTables(MyDataBase)

#campos de la tabla countrylanguaje
dbListFields(MyDataBase, 'CountryLanguage')

#almacenamos en la variable  los datos
paisl <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
names(paisl)
paisl
# español
espa <- paisl %>% filter(Language == "Spanish")
espa
espa.df <- as.data.frame(espa) 


espa.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()+
  theme_dark()