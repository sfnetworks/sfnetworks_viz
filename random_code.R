library(sfnetworks)
library(ggraph)

library(tidygraph)
library(sf)
net = roxel %>%
  as_sfnetwork(directed = F)
net %>% tidygraph::as_tbl_graph()

library(ggplot2)
edges = net %>% activate(edges) %>% st_as_sf()
nodes = net %>% activate(nodes) %>% st_as_sf()
ggplot() +
  geom_sf(data = edges) +
  geom_sf(data = nodes)

ggraph(net)
