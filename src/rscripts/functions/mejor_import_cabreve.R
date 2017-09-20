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
base_df <-
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
         landholder="value.y", level1="value.x.y", level2="value.x.x.y")

base_df$id_level1 <- 
  base_df %>% 
  group_indices(level1)

base_df$id_level2 <- 
  base_df %>% 
  group_indices(level2)

base_edge_list<-
  base_df %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category)


# Area aggregations
base_node_list <- 
  base_df %>% 
  filter(var_category != 'Limits') %>% 
  dcast(id_landholder+landholder+id_level1+level1+id_level2+level2+id_plot~var,value.var = "value") %>% 
  mutate(Area=as.numeric(Area)) %>% 
  mutate(Area_m2=Area * as.numeric(select(filter(context_data,key=="Area_Conv"),value)))


landholders<-
  base_node_list %>% 
  group_by(id_landholder,landholder) %>% 
  summarise(Area_m2=sum(Area_m2),Area=sum(Area))

agg1<-
  base_node_list %>% 
  group_by(level_1) %>%
  summarise(Area_m2=sum(Area_m2),Area=sum(Area))

agg2<-
  base_node_list %>% 
  group_by(level_2) %>%
  summarise(Area_m2=sum(Area_m2),Area=sum(Area))

# Other edges
natural<-
  base_edge_list %>% 
  filter(var=="Natural") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value")
natural$id <- 
  natural %>% 
  group_indices(label)

anthropic<-
  base_edge_list %>% 
  filter(var=="Anthropic") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value")
anthropic$id <- 
  anthropic %>% 
  group_indices(label)

administrative<-
  base_edge_list %>% 
  filter(var=="Administrative") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value")
administrative$id <- 
  administrative %>% 
  group_indices(label)

# Just neighbour's edge list
just_neighbours<-
  base_edge_list %>% 
  filter(var=="Neighbours") %>% 
  select(value) %>% 
  rename(landholder="value") %>% 
  unique() %>% 
  anti_join(., landholders, by = c("landholder"))
just_neighbours$id_landholder<-
  just_neighbours %>% 
  group_indices(landholder) + max(landholders$id_landholder)

# People list                 
people<-
  just_neighbours %>% 
  bind_rows(landholders) %>%
  replace_na(list(Area=0,Area_m2=0))
  
  
