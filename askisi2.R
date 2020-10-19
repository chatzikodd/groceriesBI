library(arules)
groceriesProcessed <- read.csv("Data/GroceriesProcessed.csv", header=TRUE,sep = ",",
                               stringsAsFactors = FALSE, check.names=FALSE)
# asd <-read.csv("Data/GroceriesProcessed.csv", header=TRUE,sep = ",",
#                stringsAsFactors = FALSE, check.names=FALSE,colClasses = "factor")
# summary(asd)


groceriesProcessed
products_columns <- c("citrus fruit", "tropical fruit", "whole milk", "other vegetables", "rolls/buns", "chocolate", "bottled water", "yogurt",
                     "sausage", "root vegetables", "pastry", "soda","cream")
excess_columns <- c("id","recency_days","basket_value","low_value_basket","medium_value_basket","high_value_basket")

df <- groceriesProcessed
df2 <- df
df2[,"id"]<-NULL
df2[,"basket_value"]<-NULL
df2[,"recency_days"]<-NULL
for (column_name in excess_columns){df[,column_name] <- NULL}
summary(df)

##?????????????? ?????? rhs ?????????????????? ?????? yes/no ?????????????? ???? ???????????? ?????????????? ???? ??????????
grocery_rules <- apriori(df,
                         parameter = list(supp = 0.001, conf = .6,target = "rules",minlen = 2,maxlen = 4),
                         control = list(verbose = FALSE),appearance=list(rhs=c("whole milk=yes"),default="lhs"))
inspect(grocery_rules[1:20])

rules_c <-apriori(df2,parameter = list(supp = 0.001, conf = .6,target = "rules",minlen = 3,maxlen = 4),
                  control = list(verbose = FALSE))
inspect(sort(rules_c[1:20],by="lift"))