library(magrittr)
library(yaml)
library(dplyr)
library(tidyr)
library(reshape2) # Reshape lists is not implemented in tidyr

yaml <- yaml.load_file("git/capbreu-builder/src/data/capbreu_full.yml")

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

base_df$plot.id <- 
  base_df %>% 
  group_indices(plot.id)

# Order columns
base_df<-
  base_df %>% 
  select(value, var, var_category,
         landholder.id, landholder.label,
         plot.id, plot.label,
         level1.id, level1.label,
         level2.id, level2.label)
base_df$plot.id<-
  base_df %>% 
  group_indices(plot.label) + max(base_df$landholder.id)
base_df$level1.id<-
  base_df %>% 
  group_indices(level1.label) + max(base_df$plot.id)
base_df$level2.id<-
  base_df %>% 
  group_indices(level2.label) + max(base_df$level1.id)


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
  mutate(type="landholder",shape="dot") %>% 
  rename(id="landholder.id",label="landholder.label")
#View(landholders)

plots<-
  base_node_list %>% 
  select(starts_with("plot"),starts_with("area")) %>% 
  mutate(type="plot",shape="square") %>% 
  rename(id="plot.id",label="plot.label")
#View(plots)

#l1_name<-context_data[which(context_data$key=="Level_1"), "value"]
level1<-
  base_node_list %>% 
  rename(id="level1.id",label="level1.label") %>% 
  group_by(id,label) %>%
  summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
  mutate(type="level1")
#View(level1)

#l2_name<-context_data[which(context_data$key=="Level_2"), "value"]
level2<-
  base_node_list %>%
  rename(id="level2.id",label="level2.label") %>% 
  group_by(id,label) %>%
  summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
  mutate(type="level2")
#View(level2)



# Just neighbour's edge list
neighbours<-
  base_df %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category) %>% 
  filter(var=="Neighbours") %>% 
  select(value) %>% 
  rename(label="value") %>% 
  unique() %>% 
  anti_join(., landholders, by = c("label")) %>% 
  mutate(type="just_neighbour")
neighbours$id<-
  neighbours %>% 
  group_indices(label) + max(level2$id)
#View(neighbours)

# People list                 
people<-
  neighbours %>% 
  bind_rows(landholders)
#View(people)

# Other nodes
natural<-
  base_df %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category) %>% 
  filter(var=="Natural") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value") %>% 
  mutate(type="natural")
natural$id <- 
  natural %>% 
  group_indices(label) + max(people$id)
#View(natural)

anthropic<-
  base_df %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category) %>% 
  filter(var=="Anthropic") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value") %>% 
  mutate(type="anthropic")
anthropic$id <- 
  anthropic %>% 
  group_indices(label) + max(natural$id)
#View(anthropic)

administrative<-
  base_df %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category) %>% 
  filter(var=="Administrative") %>% 
  select(value) %>% 
  unique() %>% 
  rename(label="value") %>% 
  mutate(type="administrative")
administrative$id <- 
  administrative %>% 
  group_indices(label) + max(anthropic$id)
#View(administrative)
  
nodes<-
  people %>% 
  bind_rows(plots) %>%
  bind_rows(level1) %>%
  bind_rows(level2) %>%
  bind_rows(natural) %>%
  bind_rows(anthropic) %>% 
  bind_rows(administrative) %>% 
  arrange(id)
#View(nodes)

# EDGES
# Base DataFrame for building different edge lists
base_edge_list<-
  base_df %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category) %>% 
  rename(label="value") %>% 
  left_join(nodes,by="label") %>% 
  select(-starts_with("area"),-type) %>% 
  rename(value.id="id",value.label="label",value.type="var")
#View(base_edge_list)

# EXPLICIT RELATIONSHIPS
landholder_neighbour<-
  base_edge_list %>% 
  filter(value.type=="Neighbours") %>% # Keep all repeated links, one relationship can appear more than once
  select(landholder.id, value.id) %>% 
  rename(from="landholder.id",to="value.id") %>% 
  mutate(label="neighbours",type="neighbourhood") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(landholder_neighbour)

landholder_level1<-
  base_edge_list %>% 
  select(landholder.id, level1.id) %>%
  rename(from="landholder.id",to="level1.id") %>% 
  mutate(label="is member of",type="level1-member") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(landholder_level1)


landholder_level2<-
  base_edge_list %>% 
  select(landholder.id, level2.id) %>%
  rename(from="landholder.id",to="level2.id") %>% 
  mutate(label="is member of",type="level2-member") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(landholder_level2)


plot_landholder<-
  base_edge_list %>% 
  select(landholder.id, plot.id) %>%
  rename(from="landholder.id",to="plot.id") %>% 
  mutate(label="holded by",type="landholding") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(plot_landholder)


plot_level1<-
  base_edge_list %>% 
  select(plot.id,level1.id) %>%
  distinct() %>% 
  rename(from="plot.id",to="level1.id") %>% 
  mutate(label="belongs to",type="level1-part") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(plot_level1)


plot_level2<-
  base_edge_list %>% 
  select(plot.id,level2.id) %>%
  distinct() %>% 
  rename(from="plot.id",to="level2.id") %>% 
  mutate(label="belongs to",type="level2-part") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(plot_level2)


# EDGES EXTRACTED FROM IMPLICIT TOPOLOGY
flipped_edges<-
  base_edge_list %>% 
  rename(value.id="landholder.id",value.label="landholder.label",landholder.id="value.id",landholder.label="value.label")

implicit_plot_l1<-
  flipped_edges %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id","level1.id","level2.id")) %>%
  filter(plot.id.x != plot.id.y) %>% 
  select(starts_with("plot.id"))
implicit_plot_l1<- 
  unique(data.frame(t(apply(implicit_plot_l1,1,sort))))
implicit_plot_l1.final<-
  implicit_plot_l1 %>% 
  mutate(label="touches",type="plot-border") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(implicit_plot_l1.final)


# Neighbour plots within the same level2, but not same level1
implicit_plot_l2<-
  flipped_edges %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id","level2.id")) %>%
  filter(plot.id.x != plot.id.y) %>% 
  select(starts_with("plot.id"))
implicit_plot_l2<-
  unique(data.frame(t(apply(implicit_plot_l2,1,sort)))) %>% 
  setdiff(implicit_plot_l1)
implicit_plot_l2.final<-
  implicit_plot_l2 %>% 
  mutate(label="touches",type="plot-border-l1") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(implicit_plot_l2.final)

# Neighbour plots at different l1 and l2
implicit_plot_l3<-
  flipped_edges %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id")) %>%
  filter(plot.id.x != plot.id.y) %>% 
  select(starts_with("plot.id"))
implicit_plot_l3<-
  unique(data.frame(t(apply(implicit_plot_l3,1,sort)))) %>% 
  setdiff(implicit_plot_l1) %>%
  setdiff(implicit_plot_l2)
implicit_plot_l3.final<-
  implicit_plot_l3 %>% 
  mutate(label="touches",type="plot-border-l2") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(implicit_plot_l3.final)

plot_plot<-
  implicit_plot_l1.final %>% 
  bind_rows(implicit_plot_l2.final) %>%
  bind_rows(implicit_plot_l3.final) %>% 
  arrange(from)
#View(plot_plot)


# Implicit relationships between level1 zones
implicit_l1_l1<-
  flipped_edges %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id")) %>%
  filter(level1.id.x != level1.id.y) %>% 
  select(starts_with("level1.id"))
implicit_l1_l1<- 
  unique(data.frame(t(apply(implicit_l1_l1,1,sort))))
implicit_l1_l1.final<-
  implicit_l1_l1 %>% 
  mutate(label="touches",type="level1-border") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(implicit_l1_l1.final)

# Implicit relationships between level1 zones
implicit_l2_l2<-
  flipped_edges %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id")) %>%
  filter(level2.id.x != level2.id.y) %>% 
  select(starts_with("level2.id"))
implicit_l2_l2<- 
  unique(data.frame(t(apply(implicit_l2_l2,1,sort))))
implicit_l2_l2.final<-
  implicit_l2_l2 %>% 
  mutate(label="touches",type="level2-border") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,label,to,type) %>% 
  arrange(from)
#View(implicit_l2_l2.final)

edges<-
  landholder_neighbour %>%
  bind_rows(landholder_level1) %>%
  bind_rows(landholder_level2) %>%
  bind_rows(plot_plot) %>%
  bind_rows(plot_level2) %>%
  bind_rows(plot_level1) %>%
  bind_rows(plot_landholder) %>% 
  bind_rows(implicit_l1_l1.final) %>% 
  bind_rows(implicit_l2_l2.final) %>% 
  arrange(from)
#View(edges) # TODO: Need to aggregate unique relationships?

# Examine the data
head(nodes)
head(edges)
nrow(nodes); length(unique(nodes$id))
nrow(edges); nrow(unique(edges[,c("from", "to")]))

# TODO: Need to review ids
# GRAPH (order is important)
nodes.i<-
  landholders %>% 
  bind_rows(level2) %>% 
  rename(name="id") %>% 
  select(name,label,type)

edges.i<-
  landholder_level2 %>% 
  select(from,to,type)

g <- graph_from_data_frame(edges.i, directed=TRUE, vertices=nodes.i)
data <- toVisNetworkData(g)
visNetwork(nodes = data$nodes, edges = data$edges, height = "500px")
