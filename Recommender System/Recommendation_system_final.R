#connect to database
library(RODBC)
ch <- odbcConnect(dsn = "BSUSR_CUSTANA", uid = "MKTG_PRD_CUSTANA", pwd = "analytics")
odbcClose(ch)


#extract the dataset
rdata=sqlQuery(ch, paste('SELECT *
                         FROM BSUSR_CUSTANA.RS_TOP_CUSTOMER'))

#The dataset is too large, taking a sample
# set.seed(123)
# sub <- sample(seq_len(nrow(rdata)), size = 1000, replace=FALSE)
# subs <- rdata[sub, ]


#####following procedures are performed on the sample############
#transform to an ulitility matrix, perference is the demand score
#row.names(subs)<-subs[,1]

#replace primary site_id with numerial numbering to faciliate calculation
subs=rdata
row.names(subs)<-rdata[,1]
subs=subs[,-1]
UtilityMatrix<-as.matrix(subs)
UtilityMatrix[1:10,]

#key problem: how to fill the NAs in the ulititlity matrix
#more important question: what NAs are likely to be high in value

####Collaborative Filtering
###user x user

#centeredUtilityMatrix<-t(apply(UtilityMatrix,1, function(row){return(row-mean(row,na.rm = T))}))


#Fuction used to calculate distance between user
cosSim <- function(v1, v2){
  return((v1 %*% v2)/norm(v1,type = "2")/norm(v2,type = "2"))
}

#userSimilarity <- apply(centeredUtilityMatrix, 1, function(user1){
#  apply(centeredUtilityMatrix, 1, function(user2){
#    return(cosSim(user1, user2))
#  })
#})

#userSimilarity
#some rows have all NA value

#userUserPrediction <- vector()
#a=sort(userSimilarity[2, -2], decreasing = T)[1:2]
#colSums(centeredUtilityMatrix[names(a),]/2,na.rm = T)
#names(a)
#all(is.na(userSimilarity[3, -3]))


#for (i in 1:nrow(userSimilarity)){
#  top2 <- sort(userSimilarity[i, -i], decreasing = T)[1:2]
#  userUserPrediction <- rbind(userUserPrediction,
                              # colSums(centeredUtilityMatrix[names(top2),]/2, na.rm = T))
#}

#userUserPrediction <- as.matrix(userUserPrediction)
#rownames(userUserPrediction) <- rownames(UtilityMatrix)


### remember to plug back in known ratings 
#for (i in 1:nrow(userUserPrediction)){
#  for (j in 1:ncol(userUserPrediction)){
#    if (centeredUtilityMatrix[i, j] != 0){
#      userUserPrediction[i,j] <- centeredUtilityMatrix[i, j]
#    }
#  }
#}

#userUserPrediction <- round(userUserPrediction, 4)
#pred.ranking=predictedRankings(userUserPrediction)

#helpful function

#return the class name by order
predictedRankings1 <- function(prediction){
  t(apply(prediction, 1, function(row){
    return(names(row))
  }))
}

#assign a rank to each cell
predictedRankings<-function(prediction){
  t(apply(prediction, 1, function(row){
       return((rank(-row, ties.method='min')))
      }))
    }



userSimilarity1 <- apply(UtilityMatrix, 1, function(user1){
  apply(UtilityMatrix, 1, function(user2){
    return(cosSim(user1, user2))
  })
})

#calculate the distance between customers
##find top three most similar customer and use their average rating for class
userUserPrediction1 <- vector()
for (i in 1:nrow(userSimilarity1)){
  top3 <- sort(userSimilarity1[i, -i], decreasing = T)[1:5]
  userUserPrediction1 <- rbind(userUserPrediction1,
                              colSums(UtilityMatrix[names(top3),]/5, na.rm = T))
}
  
userUserPrediction1 <- as.matrix(userUserPrediction1)
userUserPrediction1[10:20,10:20]
subs[10:20,10:20]

#plug back original values
#for (i in 1:nrow(userUserPrediction1)){
#  for (j in 1:ncol(userUserPrediction1)){
#    if (UtilityMatrix[i, j] != 0){
#      userUserPrediction1[i,j] <- UtilityMatrix[i, j]
#    }
#  }
#}

#round the prediction score to 4 digits decimal
userUserPrediction1 <- round(userUserPrediction1, 4)

#return the rank of each cell
pred.ranking1=predictedRankings(userUserPrediction1)

#fill each cell with class name, for future use
pred_ranking1=predictedRankings1(userUserPrediction1)
write.csv(pred.ranking1,'pred.ranking1.csv')

#convert to a list, so every customer represents an element in the list
#Th following part is created recommendation list, but may include what customers have purchased before
xy.list <- setNames(split(pred.ranking1, seq(nrow(pred.ranking1))), rownames(pred.ranking1))
xy.list1<-setNames(split(pred_ranking1, seq(nrow(pred_ranking1))), rownames(pred_ranking1))
xy.list1[1:3]

#create a list only containing rated products for each customer
xy.list2<-list()
for (i in 1:length(xy.list)){
  m=unlist(lapply(xy.list[i],function(x) max(x)))
  xy.list2[[i]]=xy.list1[[i]][unlist(lapply(xy.list[i],function(x) which(x!=m)),use.names = T)]
  }

write.csv(xy.list2,"list2.csv")
lapply(xy.list2, write,"list2.txt",append=TRUE,ncolumns=1100)


#create a list only containing their frequency for each product 
xy.list3<-list()
for (i in 1:length(xy.list)){
  m=unlist(lapply(xy.list[i],function(x) max(x)))
  xy.list3[[i]]=xy.list[[i]][unlist(lapply(xy.list[i],function(x) which(x!=m)),use.names = T)]
}


#match these two lists together
xy.list4<-list()
for (i in 1:length(xy.list2)){
  x=unlist(xy.list2[i])
  y=unlist(xy.list3[i])
  xy.list4[[i]]=x[order(y)]
}

lapply(xy.list4, write,"list5.txt",append=TRUE,ncolumns=1100)

#convert sample data subs to a list
#This part is to create a equivalent list that contains what customers have purchased before
xy.list5 <- setNames(split(subs, seq(nrow(subs))), rownames(subs))
xy.list5[1:2]

#create a list only containing product purchased
xy.list6<-list()
for (i in 1:length(xy.list5)){
  xy.list6[[i]]=xy.list1[[i]][unlist(lapply(xy.list5[i],function(x) which(x!='0')),use.names = T)]
}

xy.list6[1:3]
#create a list containing frequency
xy.list7<-list()
for (i in 1:length(xy.list5)){
  xy.list7[[i]]=xy.list5[[i]][unlist(lapply(xy.list5[i],function(x) which(x!=0)),use.names = T)]
}

#match these two lists together
xy.list8<-list()
for (i in 1:length(xy.list7)){
  x=unlist(xy.list6[i])
  y=unlist(xy.list7[i])
  xy.list8[[i]]=x[order(y,decreasing=TRUE)]
}


#substract xy.list 8 from xy.list 4
xy.list9<-list()
for (i in 1:length(xy.list8)){
  a=unlist(xy.list4[i])
  xy.list9[[i]]=c(rownames(vdata1[i,]),a[!(unlist(xy.list4[i]) %in% unlist(xy.list8[i]))])
}
b=unlist(xy.list9[1:2])
b
xy.list10=gsub("c474", "huahua", xy.list9)

xy.list10<-list()
for (i in 1:length(xy.list9)){
  a=unlist(xy.list9[i])
  b=gsub('c298','Copy Center Misc,',a)
  b=gsub('c408','FedEx,',b)
  b=gsub('c409','Packing Services,',b)
  b=gsub('c410','Third Party Posters,',b)
  b=gsub('c411','Third Party Banners,',b)
  b=gsub('c412','Color Engineering Prints,',b)
  b=gsub('c413','Third Party Flyers,',b)
  b=gsub('c414','Makr,',b)
  b=gsub('c415','Photo Printing,',b)
  b=gsub('c456','UNASSIGNED BUSINESS SERVI,',b)
  b=gsub('c471','PTO/STEP Core Print,',b)
  b=gsub('c472','Banner Accessories,',b)
  b=gsub('c474','Labels,',b)
  b=gsub('c475','Outsource Custom Print,',b)
  b=gsub('c476','PTO/STEP Custom Print,',b)
  b=gsub('c477','Outsource Wide Format,',b)
  b=gsub('c479','PTO/STEP Wide Format,',b)
  b=gsub('c482','Web & Digital Services,',b)
  b=gsub('c484','In House Photobooks,',b)
  b=gsub('c485','In House Cards & Invitations,',b)
  b=gsub('c496','In House Brochures,',b)
  b=gsub('c497','Canvas Prints,',b)
  b=gsub('c498','In House Posters,',b)
  b=gsub('c600','Business Services Resale Merch,',b)
  b=gsub('c601','In House Business Cards,',b)
  b=gsub('c602','In House Flyers,',b)
  b=gsub('c603','In House Postcards,',b)
  b=gsub('c604','In House Signs & Banners,',b)
  b=gsub('c605','Direct Mail Services,',b)
  b=gsub('c606','In House Calendars,',b)
  b=gsub('c607','Computer Workstation,',b)
  b=gsub('c608','In House Other,',b)
  b=gsub('c609','Self Serve Color Copying,',b)
  b=gsub('c610','Full Serve Color Copying,',b)
  b=gsub('c611','Self Serve B&W Copying,',b)
  b=gsub('c612','Full Serve B&W Copying,',b)
  b=gsub('c613','B&W Engineering Prints,',b)
  b=gsub('c614','Binding Services,',b)
  b=gsub('c615','Folding Services,',b)
  b=gsub('c616','Cutting & Drilling Services,',b)
  b=gsub('c617','Laminating,',b)
  b=gsub('c618','In House S&B Finsihing,',b)
  b=gsub('c619','In House Signs/Displays,',b)
  b=gsub('c620','3rd Party Bus Cards,',b)
  b=gsub('c621','3rd Party Bus Letterhead,',b)
  b=gsub('c622','3rd Party Promo Printing,',b)
  b=gsub('c623','3rd Party Bus Envelopes,',b)
  b=gsub('c624','3rd Party Carbonless Form,',b)
  b=gsub('c625','3rd Party Postcards,',b)
  b=gsub('c626','3rd Party Check Printing,',b)
  b=gsub('c627','3rd Party Other,',b)
  b=gsub('c628','3rd Party Label Printing,',b)
  b=gsub('c629','Paper Upgrades,',b)
  b=gsub('c630','3rd Party Custom Stamps,',b)
  b=gsub('c631','3rd Party Engr Sign&Badge,',b)
  b=gsub('c632','Third Party Brochures,',b)
  b=gsub('c633','In House Brother Stamp,',b)
  b=gsub('c634','3rd Party Signs/Displays,',b)
  b=gsub('c635','Full Service Labor,',b)
  b=gsub('c636','Tests,',b)
  b=gsub('c639','Photo Gifts,',b)
  b=gsub('c640','Staples Promotional Products,',b)
  b=gsub('c641','3rd Party Cards & Invitations,',b)
  b=gsub('c642','3rd Party Calendars,',b)
  b=gsub('c643','Outsource Core Print,',b)
  b=gsub('c650','Shredding,',b)
  b=gsub('c651','Full Serve Fees,',b)
  b=gsub('c652','Scanning,',b)
  b=gsub('c653','3D Printing Services,',b)
  b=gsub('c654','Branding/Design Services,',b)
  b=gsub('c660','Faxing,',b)
  b=gsub('c671','UPS/Purolator,',b)
  b=gsub('c672','Dotcom 3rd Party Shipping,',b)
  b=gsub('c673','USPS,',b)
  b=gsub('c677','Contract DCS Proprietary,',b)
  b=gsub('c678','Contract Print Proprietary,',b)
  b=gsub('c679','Contract Test/Other,',b)
  xy.list10[[i]]=b
}
lapply(xy.list9, write,"list9.txt",append=TRUE,ncolumns=1100)

#recommendation1.txt is the final recommendation list
xy.list10[1:2]
lapply(xy.list10, write,"recommendation1.txt",append=TRUE,ncolumns=1100)

#####validation


#extract the dataset
library(RODBC)
ch <- odbcConnect(dsn = "BSUSR_CUSTANA", uid = "MKTG_PRD_CUSTANA", pwd = "analytics")
odbcClose(ch)

vdata=sqlQuery(ch, paste('SELECT *
                         FROM BSUSR_CUSTANA.RS_TOP_CUSTOMER_valid'))
rownames(vdata)=vdata[,1]
vdata=vdata[,-1]

#merge two dataset together
combine=merge(x =rdata , y = vdata, by = "PRIMARY_SITE_ID", all.x = TRUE)
vdata1=combine[,-(2:78)]
sum(is.na(vdata1[2])) #2196 NA
rownames(vdata1)=vdata1[,1]
vdata1=vdata1[,-1]

xy.list11 <- setNames(split(vdata1, seq(nrow(vdata1))), rownames(vdata1))
xy.list11[1]


#actual buying list
xy.list12<-list()
for (i in 1:length(xy.list11)){
  xy.list12[[i]]=xy.list1[[i]][unlist(lapply(xy.list11[i],function(x) which(x!='0')),use.names = T)]
}

lapply(xy.list12, write,"list12.txt",append=TRUE,ncolumns=1100)

#in both recommendation and actual list
xy.vector<-list()
for (i in 1:length(xy.list9)){
  a=unlist(xy.list9[i])
  xy.vector[[i]]=c(rownames(vdata1[i,]),a[(unlist(xy.list9[i]) %in% unlist(xy.list12[i]))])
}
d=lapply(xy.vector,is.null)
xy.vector[1:6]

lapply(xy.vector, write,"list13.txt",append=TRUE,ncolumns=1100)

d=0
for (i in 1:length(xy.vector)){
  if (length(unlist(xy.vector[i]))>1){d=d+1}
}

####
7806 out of 10000 purchase in the next period,and among them, 3280 buy at least one product on the recommendation list

d

