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

layout_sf <- function(graph){
  graph %>% 
    activate("nodes") %>% 
    mutate(
      x = sf::st_coordinates(.)[,"X"],
      y = sf::st_coordinates(.)[,"Y"]
    )
}

roxel %>%
  as_sfnetwork(directed = F, edges_as_lines = TRUE) %>% 
  ggraph(layout = layout_sf) +
  geom_node_point()

foo <- function(){
  function(layout) {
    attr(layout, "graph") %>% 
      as_sfnetwork(directed = FALSE) %>% 
      activate("edges") %>% 
      sf::st_as_sf()
  }
}

roxel %>%
  as_sfnetwork(directed = F, edges_as_lines = TRUE) %>% 
  ggraph(layout = layout_sf) +
  geom_node_point() + 
  geom_sf(
    data = foo()
  )
