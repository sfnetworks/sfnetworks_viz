library(ggraph)
library(ggplot2)
library(tidygraph)
library(sfnetworks)

data("roxel", package = "sfnetworks")

# ggraph
roxel_net <- as_sfnetwork(roxel, directed = F) 

# computes layout
roxel_net %>% 
  as_tbl_graph() %>% 
  ggraph() +
  geom_node_point() +
  geom_edge_link()


# use 
roxel_net %>% 
  as_tbl_graph() %>% 
  ggraph() +
  geom_sf(data = roxel)

layout_sf <- function(graph){
  graph %>% 
    to_spatial_coordinates() %>% 
    .$coords_graph %>% 
    rename(x = X, y = Y)
}

# computes layout
roxel %>%
  as_sfnetwork(roxel, directed = F, edges_as_lines = FALSE) %>% 
  ggraph(layout = layout_sf) +
  geom_node_point() +
  geom_edge_link()