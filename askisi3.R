library(skmeans)
groceriesProcessed <- read.csv("Data/GroceriesProcessed.csv", header=TRUE,sep = ",",
                               stringsAsFactors = FALSE, check.names=FALSE)
df <- groceriesProcessed[,2:3]
# df <- scale(df)
# groceries
fit <- kmeans(df,centers = 5,iter.max = 10,nstart = 2,trace = FALSE)
df_cluster_mean <- aggregate(df,by = list(fit$cluster),FUN = mean)
df_cluster_sd <- aggregate(df,by = list(fit$cluster),FUN = sd)
df_cluster_mean
df_cluster_sd
mydf <- data.frame(df,fit$cluster)
cluster_column = mydf[,3]
Cluster_columns = c("cluster1","cluster2","cluster3","cluster4","cluster5") 
#
groceriesProcessed[,"Cluster"] <- mydf[,3]
for (column in Cluster_columns){groceriesProcessed[i,column] <- "no"}
head(groceriesProcessed)
for(i in 1:nrow(groceriesProcessed)){
  string<-paste("cluster",groceriesProcessed[i,"Cluster"],sep="",collapse=NULL)
  groceriesProcessed[i,string]<- "yes"
}
head(groceriesProcessed)
write.csv(groceriesProcessed,file = "Data/GroceriesClustered.csv",row.names = FALSE,na="no")
