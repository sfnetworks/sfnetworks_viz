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
    activate("nodes") %>% 
    mutate(
      x = sf::st_coordinates(.)[,"X"],
      y = sf::st_coordinates(.)[,"Y"]
    )
}

edges <- roxel %>% 
  as_sfnetwork(directed = FALSE) %>% 
  activate("edges") %>% 
  sf::st_as_sf()

geom_edge_spatial = function(x, ...) {
  edges = sf::st_as_sf(x, 'edges')
  geom_sf(data = edges, ...)
}

# computes layout
ig <- roxel %>%
  as_sfnetwork(directed = F, edges_as_lines = TRUE) %>% 
  ggraph(layout = layout_sf) +
  geom_node_point() +
  geom_edge_link(aes(color = type))


geom_edge_sf <- function(p, ...){
  edges <- attr(p$data, "graph") %>% 
    as_sfnetwork(directed = FALSE) %>% 
    activate("edges") %>% 
    sf::st_as_sf()
  p + geom_sf(data = edges, ...)
}

foo <- function(){
  attr(data, "graph") %>% 
    as_sfnetwork(directed = FALSE) %>% 
    activate("edges")
}

roxel %>%
  as_sfnetwork(directed = F, edges_as_lines = TRUE) %>% 
  ggraph(layout = layout_sf) +
  geom_node_point() + 
  geom_sf(
    data = foo()
  )

p

edges <- attr(p$data, "graph") %>% 
  as_sfnetwork(directed = FALSE) %>% 
  activate("edges") %>% 
  sf::st_as_sf()

p + geom_sf(data = edges)
