library('igraph')

setwd('/Users/yiqian/Documents/BigdataPro1/')
a = list.files('Edges/')
dir = paste('Edges/', a, sep="")
n = length(dir)
b = list.files('Circles/')
dir1 = paste('Circles/', b, sep="")

relations = data.frame()
nodeID = data.frame()
IDlist = as.list(nodeID)

for (file in dir){
  g = scan(file)
  if (!inherits(g, 'try-error')) g
  glist = as.list(g)
  circleNum = scan(file, what='list', flush=TRUE)

  nodeID = gsub("Edges/", "", file)
  nodeID = as.numeric(gsub(".edges", "", nodeID))
  IDlist = c(IDlist, nodeID)
  
  if (length(glist) != 0){
    for (temp in glist){
      if (temp>100){
        tempEdge = data.frame(from=nodeID, to=temp)
        IDlist = c(IDlist, temp)
        relations = rbind(relations, tempEdge)
      }
    }
  }
}

for (file1 in dir1[1:5]){
  g1 = scan(file1)
  if (!inherits(g1, 'try-error')) g1
  g1list = as.list(g1)
  circle1Num = scan(file, what='list', flush=TRUE)
  
  if (length(g1list) != 0){
    start = g1list[0]
    for (temp in g1list[2:]){
      if (temp>100){
        tempEdge = data.frame(from=nodeID, to=temp)
        IDlist = c(IDlist, temp)
        relations = rbind(relations, tempEdge)
      }
    }
  }
}

node = as.list(data.frame())
for(i in 1:nrow(relations)){
  for(j in 1:ncol(realtions)){
    node = c(node, relations[i, j])
  }
}

#remove duplicate node
unique(node)

temp_node = data.frame(name = node)

g = graph_from_data_frame(relations, directed=TRUE, vertices=NULL)

#remove circle and multiple edges
g = simplify(g)

plot(g, vertex.size=2, vertex.label=NA, layout=layout.auto, edge.color=red(0.5), edge.arrow.mode="-")

#--------------------------------------------------------------
# Question 4 Explore 10 functions

# dfs with node 1000 as root
dfs(g, 1000)

# bfs with node 1000 as root
bfs(g, 1000)

# is the graph directed
is.directed(g)

# is the graph weighted
is.weighted(g)

# is the graph simple
is.simple(g)

# get closeness centrality of vertices
closeness(g)

# find loop edges
closeness(g)

# is the graph connected
is.connected(g)

# count edge
ecount(g)

# average path length
average.path.length(g)
     
#---------------------------------------------------------------
# Question 5
     
# central persons
central_person = alpha.centrality(g)
CP = tail(sort(central_person), 5)
print("central person: ")
print(as.list(CP))

# longest path
longest_path <- get_diameter(g)
print('longest path')
print(longest_path)

#largest clique
largest_cliques <- largest_cliques(g)
print("largest_cliques ")
print(largest_cliques)

# ego
ego = ego(g, gorder(g), V(g))
print('ego')
print(ego)

# betweenness and power
betweenness = betweenness(g)
print("betweenness centrality ")
print(betweenness)
power = power_centrality(g)
print('power centrality')
print(power)
