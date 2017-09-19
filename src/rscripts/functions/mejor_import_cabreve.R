library(magrittr)
library(yaml)
library(dplyr)
library(tidyr)
library(reshape2) # Reshape lists is not implemented in tidyr

yaml <- yaml.load_file("src/data/capbreu_latest_fullname.yml")

# Project data
proj_data <-
  yaml %$%
  data.frame(Structure,Title,Description) %>% 
  gather()

# Context data
context_data <-
  yaml %$%
  data.frame(Landmetrics,Aggregations) %>% 
  gather()

# Later Replace Ls by level names LABELS
l1_name<-context_data[which(context_data$key=="Level_1"), "value"]
l2_name<-context_data[which(context_data$key=="Level_2"), "value"]
#schema_data[which(schema_data$var=="Level_2"), "var"] <- l2_name
#schema_data[which(schema_data$var=="Level_1"), "var"] <- l1_name


# Schema Data
schema_data <-
  yaml %$% 
  Landholders %>%
  melt() %>%
  left_join(.,filter(select(.,value,L1,L2),L2=="Name"), by="L1") %>%
  select(-starts_with("L2")) %>% 
  drop_na() %>%
  unite(id_plot, L1, L3, sep = "-", remove = FALSE) %>% 
  select(-L3) %>% 
  left_join(.,filter(select(.,id_plot,L5,value.x),L5=="Level_1"), by="id_plot") %>%
  select(-L5.y) %>% 
  left_join(.,filter(select(.,id_plot,L5.x,value.x.x),L5.x=="Level_2"), by="id_plot") %>%
  select(-L5.x.y) %>% 
  filter(L4!="Aggregations") %>% 
  rename(value="value.x.x.x",var="L5.x.x",var_category="L4",id_landholder="L1", 
         landholder="value.y", level_1="value.x.y", level_2="value.x.x.y")

# Area aggregations
schema_data_aggregates <- 
  schema_data %>% 
  filter(var_category != 'Limits') %>% 
  dcast(landholder+id_landholder+level_1+level_2+id_plot~var,value.var = "value") %>% 
  mutate(Area=as.numeric(Area)) %>% 
  mutate(Area_m2=Area * as.numeric(select(filter(context_data,key=="Area_Conv"),value)))
  

landholders <- aggregate(schema_data_aggregates$Area_m2, by=list(schema_data_aggregates$id_landholder,schema_data_aggregates$landholder), FUN=sum, na.rm=TRUE)
colnames(landholders) <- c('id', 'landholder', 'area')

agg1<-aggregate(schema_data_aggregates$Area_m2, by=list(schema_data_aggregates$level_1), FUN=sum, na.rm=TRUE)
colnames(agg1) <- c('name', 'area')
agg1<-data.frame(id = seq(from = 1, to = length(agg1$name)),
                 name = agg1$name,
                 area = agg1$area)

agg2<-aggregate(schema_data_aggregates$Area_m2, by=list(schema_data_aggregates$level_2), FUN=sum, na.rm=TRUE)
colnames(agg2) <- c('name', 'area')
agg2<-data.frame(id = seq(from = 1, to = length(agg2$name)),
                 name = agg2$name,
                 area = agg2$area)


#################
# Other limits lists
natural <- unique(schema_data[which(schema_data$var=="Natural"),c("value")])
natural <- data.frame(id = seq(from = 1, to = length(natural)),
                    name = natural)

anthropic <- unique(schema_data[which(schema_data$var=="Anthropic"),c("value")])
anthropic<-data.frame(id = seq(from = 1, to = length(anthropic)),
                    name = anthropic)

administrative <- unique(schema_data[which(schema_data$var=="Administrative"),c("value")])
administrative <- data.frame(id = seq(from = 1, to = length(administrative)),
                      name = administrative)

# Just neighbours list
neighbours<-data.frame(name=unique(schema_data[which(schema_data$var=="Neighbours"), c("value")]))
just_neighbours<-setdiff(neighbours$name,landholders$name)
just_neighbours<-data.frame(id = seq(from = max(landholders$id), length.out = length(just_neighbours)),
                            name = just_neighbours)
# Neighbours with ids (landholders + justneighbours)
neighbours<-data.frame(id=c(landholders$id,just_neighbours$id),
                  name=c(landholders$name,as.character(just_neighbours$name)))
