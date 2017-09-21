library(magrittr)
library(yaml)
library(dplyr)
library(tidyr)
library(reshape2) # Reshape lists is not implemented in tidyr

yaml <- yaml.load_file("src/data/capbreu_full.yml")

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


# Base DataFrame for nodes and edges
base_df <-
  yaml %$% 
  Landholders %>%
  melt() %>%
  left_join(.,filter(select(.,value,L1,L2),L2=="Name"), by="L1") %>%
  select(-starts_with("L2")) %>% 
  drop_na() %>%
  unite(plot.id, L1, L3, sep = "-", remove = FALSE) %>% 
  select(-L3) %>% 
  left_join(.,filter(select(.,plot.id,L5,value.x),L5=="Level_1"), by="plot.id") %>%
  select(-L5.y) %>% 
  left_join(.,filter(select(.,plot.id,L5.x,value.x.x),L5.x=="Level_2"), by="plot.id") %>%
  select(-L5.x.y) %>% 
  filter(L4!="Aggregations") %>% 
  rename(value="value.x.x.x",var="L5.x.x",var_category="L4",landholder.id="L1", 
         landholder.label="value.y", level1.label="value.x.y", level2.label="value.x.x.y") %>% 
  mutate(plot.label=paste("plot",plot.id,sep="-"))

base_df$level1.id <- 
  base_df %>% 
  group_indices(level1.label)

base_df$level2.id <- 
  base_df %>% 
  group_indices(level2.label)

# Order columns
base_df<-
  base_df %>% 
  select(value, var, var_category,
         landholder.id, landholder.label,
         plot.id, plot.label,
         level1.id, level1.label,
         level2.id, level2.label)

# Base DataFrame for building different edge lists
base_edge_list<-
  base_df %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category)

# Base DataFrame for building different node lists
base_node_list <- 
  base_df %>% 
  filter(var_category != 'Limits') %>% 
  dcast(landholder.id+landholder.label+
          level1.id+level1.label+
          level2.id+level2.label+
          plot.id+plot.label~
          var,value.var = "value") %>% 
  rename(area="Area") %>% 
  mutate(area=as.numeric(area)) %>% 
  mutate(area_m2=area * as.numeric(select(filter(context_data,key=="Area_Conv"),value)))


landholders<-
  base_node_list %>% 
  group_by(landholder.id,landholder.label) %>% 
  summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
  mutate(type="landholder") %>% 
  rename(id="landholder.id",label="landholder.label")
View(landholders)


l1_name<-context_data[which(context_data$key=="Level_1"), "value"]
level1<-
  base_node_list %>% 
  rename(id="level1.id",label="level1.label") %>% 
  group_by(id,label) %>%
  summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
  mutate(type=l1_name)
View(level1)

l2_name<-context_data[which(context_data$key=="Level_2"), "value"]
level2<-
  base_node_list %>%
  rename(id="level2.id",label="level2.label") %>% 
  group_by(id,label) %>%
  summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
  mutate(type=l2_name)
View(level2)



# Just neighbour's edge list
just_neighbours<-
  base_edge_list %>% 
  filter(var=="Neighbours") %>% 
  select(value) %>% 
  rename(label="value") %>% 
  unique() %>% 
  anti_join(., landholders, by = c("label")) %>% 
  mutate(type="just_neighbour")
just_neighbours$id<-
  just_neighbours %>% 
  group_indices(label) + max(landholders$id)

# People list                 
people<-
  just_neighbours %>% 
  bind_rows(landholders)
View(people)

# Other nodes
natural<-
  base_edge_list %>% 
  filter(var=="Natural") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value") %>% 
  mutate(type="natural")
natural$id <- 
  natural %>% 
  group_indices(label) + max(people$id)
View(natural)

anthropic<-
  base_edge_list %>% 
  filter(var=="Anthropic") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value") %>% 
  mutate(type="anthropic")
anthropic$id <- 
  anthropic %>% 
  group_indices(label) + max(natural$id)
View(anthropic)

administrative<-
  base_edge_list %>% 
  filter(var=="Administrative") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value") %>% 
  mutate(type="administrative")
administrative$id <- 
  administrative %>% 
  group_indices(label) + max(anthropic$id)
View(administrative)
  
nodes<-
  people %>% 
  bind_rows(level1) %>%
  bind_rows(level2) %>%
  bind_rows(natural) %>%
  bind_rows(anthropic) %>% 
  bind_rows(administrative)
View(nodes)

