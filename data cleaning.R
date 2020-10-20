library(tidyverse)

# The empty columns and useless columns(only 1 unique value) has been deleted in excel in advance


# Import the data

berry<- read.csv("/Users/angryboats/Desktop/berries.csv", header=T)

# Take only bluberries and year period into consideration

berry_blue <- berry %>% filter((Commodity=="BLUEBERRIES") & (Period=="YEAR"))

# Delete unnecessary columns

berry_blue %<>% select(-2, -4, -5)

# Seperate data item column

berry_blue %<>% separate(`Data.Item`, c("berry", "type", "data_item", "unit"), ",")
berry_blue %<>% select(-3)

# Type and ata_item still messy, so check the value type

berry_blue$type %>% unique()

berry_blue$data_item %>% unique()

# Reorganize the data_item column and unit column

for (i in 1:7419){
  if (is.na(berry_blue$data_item[i])) {
    berry_blue$data_item[i]=" "
  }
}


for (i in 1:7419){
  if (str_detect(berry_blue$data_item[i], "MEASURED")){
    berry_blue$unit[i]=berry_blue$data_item[i]
    berry_blue$data_item[i]=" "
  }
}

# Reorganize the type column

berry_blue$type<-  str_split(berry_blue$type, " - ", simplify = TRUE)
berry_blue %<>% separate(type, into=c("kind", "measure"))
berry_blue %<>% select(-3)

# Change the missing values into blank space in unit column and 0 in value column

for (i in 1:7419){
  if (is.na(berry_blue$unit[i])) {
    berry_blue$unit[i]=" "
  }
}

for (i in 1:7419){
  if (str_detect(berry_blue$Value[i], "D")){
    berry_blue$Value[i]=0
  }
}

for (i in 1:7419){
  if (str_detect(berry_blue$Value[i], "NA")){
    berry_blue$Value[i]=0
  }
}

for (i in 1:7419){
  if (str_detect(berry_blue$Value[i], "Z")){
    berry_blue$Value[i]=0
  }
}

# write the file

write.csv(berry_blue, "/Users/angryboats/Desktop/blueberry.csv")
