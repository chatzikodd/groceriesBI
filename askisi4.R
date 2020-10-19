library(arules)
groceriesClustered <- read.csv("Data/GroceriesClustered.csv", header=TRUE,sep = ",",
                               stringsAsFactors = FALSE, check.names=FALSE)
df<-groceriesClustered
excess_columns_cluster <- c(excess_columns,"Cluster")
for(column in excess_columns_cluster){df[,column]<- NULL}
df
grocery_cluster_rules <- apriori(df,
                         parameter = list(supp = 0.001, conf = .6,target = "rules",minlen = 3,maxlen = 5),
                         control = list(verbose = FALSE),
                         appearance=list(rhs = c("cluster1=yes","cluster2=yes","cluster3=yes","cluster4=yes","cluster5=yes")
                                          ,default="lhs"))
top_rules<-inspect(sort(grocery_cluster_rules[1:20],by="lift"))
top_rules