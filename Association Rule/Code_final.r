library(RODBC)
ch <- odbcConnect(dsn = "PRD_MKTG_BIV", uid = "LiXi001", pwd = "temp1234")

#Retailxconsumer
Retaildata=sqlQuery(ch, paste('select a.primary_site_id
                              , SUM(case when class_id = 298 then 1 else 0 end) as "Copy Center Misc"
                              , SUM(case when class_id = 408 then 1 else 0 end) as "FedEx"
                              , SUM(case when class_id = 409 then 1 else 0 end) as "Packing Services"
                              , SUM(case when class_id = 410 then 1 else 0 end) as "Third Party Posters"
                              , SUM(case when class_id = 411 then 1 else 0 end) as "Third Party Banners"
                              , SUM(case when class_id = 412 then 1 else 0 end) as "Color Engineering Prints"
                              , SUM(case when class_id = 413 then 1 else 0 end) as "Third Party Flyers"
                              , SUM(case when class_id = 414 then 1 else 0 end) as "Makr"
                              , SUM(case when class_id = 415 then 1 else 0 end) as "Photo Printing"
                              , SUM(case when class_id = 456 then 1 else 0 end) as "UNASSIGNED BUSINESS SERVI"
                              , SUM(case when class_id = 471 then 1 else 0 end) as "PTO/STEP Core Print"
                              , SUM(case when class_id = 472 then 1 else 0 end) as "Banner Accessories"
                              , SUM(case when class_id = 474 then 1 else 0 end) as "Labels"
                              , SUM(case when class_id = 475 then 1 else 0 end) as "Outsource Custom Print"
                              , SUM(case when class_id = 476 then 1 else 0 end) as "PTO/STEP Custom Print"
                              , SUM(case when class_id = 477 then 1 else 0 end) as "Outsource Wide Format"
                              , SUM(case when class_id = 479 then 1 else 0 end) as "PTO/STEP Wide Format"
                              , SUM(case when class_id = 482 then 1 else 0 end) as "Web & Digital Services"
                              , SUM(case when class_id = 484 then 1 else 0 end) as "In House Photobooks"
                              , SUM(case when class_id = 485 then 1 else 0 end) as "In House Cards & Invitations"
                              , SUM(case when class_id = 496 then 1 else 0 end) as "In House Brochures"
                              , SUM(case when class_id = 497 then 1 else 0 end) as "Canvas Prints"
                              , SUM(case when class_id = 498 then 1 else 0 end) as "In House Posters"
                              , SUM(case when class_id = 600 then 1 else 0 end) as "Business Services Resale Merch"
                              , SUM(case when class_id = 601 then 1 else 0 end) as "In House Business Cards"
                              , SUM(case when class_id = 602 then 1 else 0 end) as "In House Flyers"
                              , SUM(case when class_id = 603 then 1 else 0 end) as "In House Postcards"
                              , SUM(case when class_id = 604 then 1 else 0 end) as "In House Signs & Banners"
                              , SUM(case when class_id = 605 then 1 else 0 end) as "Direct Mail Services"
                              , SUM(case when class_id = 606 then 1 else 0 end) as "In House Calendars"
                              , SUM(case when class_id = 607 then 1 else 0 end) as "Computer Workstation"
                              , SUM(case when class_id = 608 then 1 else 0 end) as "In House Other"
                              , SUM(case when class_id = 609 then 1 else 0 end) as "Self Serve Color Copying"
                              , SUM(case when class_id = 610 then 1 else 0 end) as "Full Serve Color Copying"
                              , SUM(case when class_id = 611 then 1 else 0 end) as "Self Serve B&W Copying"
                              , SUM(case when class_id = 612 then 1 else 0 end) as "Full Serve B&W Copying"
                              , SUM(case when class_id = 613 then 1 else 0 end) as "B&W Engineering Prints"
                              , SUM(case when class_id = 614 then 1 else 0 end) as "Binding Services"
                              , SUM(case when class_id = 615 then 1 else 0 end) as "Folding Services"
                              , SUM(case when class_id = 616 then 1 else 0 end) as "Cutting & Drilling Services"
                              , SUM(case when class_id = 617 then 1 else 0 end) as "Laminating"
                              , SUM(case when class_id = 618 then 1 else 0 end) as "In House S&B Finsihing"
                              , SUM(case when class_id = 619 then 1 else 0 end) as "In House Signs/Displays"
                              , SUM(case when class_id = 620 then 1 else 0 end) as "3rd Party Bus Cards"
                              , SUM(case when class_id = 621 then 1 else 0 end) as "3rd Party Bus Letterhead"
                              , SUM(case when class_id = 622 then 1 else 0 end) as "3rd Party Promo Printing"
                              , SUM(case when class_id = 623 then 1 else 0 end) as "3rd Party Bus Envelopes"
                              , SUM(case when class_id = 624 then 1 else 0 end) as "3rd Party Carbonless Form"
                              , SUM(case when class_id = 625 then 1 else 0 end) as "3rd Party Postcards"
                              , SUM(case when class_id = 626 then 1 else 0 end) as "3rd Party Check Printing"
                              , SUM(case when class_id = 627 then 1 else 0 end) as "3rd Party Other"
                              , SUM(case when class_id = 628 then 1 else 0 end) as "3rd Party Label Printing"
                              , SUM(case when class_id = 629 then 1 else 0 end) as "Paper Upgrades"
                              , SUM(case when class_id = 630 then 1 else 0 end) as "3rd Party Custom Stamps"
                              , SUM(case when class_id = 631 then 1 else 0 end) as "3rd Party Engr Sign&Badge"
                              , SUM(case when class_id = 632 then 1 else 0 end) as "Third Party Brochures"
                              , SUM(case when class_id = 633 then 1 else 0 end) as "In House Brother Stamp"
                              , SUM(case when class_id = 634 then 1 else 0 end) as "3rd Party Signs/Displays"
                              , SUM(case when class_id = 635 then 1 else 0 end) as "Full Service Labor"
                              , SUM(case when class_id = 636 then 1 else 0 end) as "Tests"
                              , SUM(case when class_id = 639 then 1 else 0 end) as "Photo Gifts"
                              , SUM(case when class_id = 640 then 1 else 0 end) as "Staples Promotional Products"
                              , SUM(case when class_id = 641 then 1 else 0 end) as "3rd Party Cards & Invitations"
                              , SUM(case when class_id = 642 then 1 else 0 end) as "3rd Party Calendars"
                              , SUM(case when class_id = 643 then 1 else 0 end) as "Outsource Core Print"
                              , SUM(case when class_id = 650 then 1 else 0 end) as "Shredding"
                              , SUM(case when class_id = 651 then 1 else 0 end) as "Full Serve Fees"
                              , SUM(case when class_id = 652 then 1 else 0 end) as "Scanning"
                              , SUM(case when class_id = 653 then 1 else 0 end) as "3D Printing Services"
                              , SUM(case when class_id = 654 then 1 else 0 end) as "Branding/Design Services"
                              , SUM(case when class_id = 660 then 1 else 0 end) as "Faxing"
                              , SUM(case when class_id = 671 then 1 else 0 end) as "UPS/Purolator"
                              , SUM(case when class_id = 673 then 1 else 0 end) as "USPS"
                              , SUM(case when class_id = 677 then 1 else 0 end) as "Contract DCS Proprietary"
                              , SUM(case when class_id = 678 then 1 else 0 end) as "Contract Print Proprietary"
                              , SUM(case when class_id = 679 then 1 else 0 end) as "Contract Test/Other"
                              from PRD_MKTG_BIV.SALES_VISIT_LINE a inner join PRD_MKTG_BIV.item b on a.item_id = b.item_id
                              where a.fiscal_yearmo between 201510 and 201609
                              and b.division_id = 6
                              and a.visit_line_type_code=\'TRNLIN\'
                              and a.identifiable_ind=\'Y\'
                              and a.business_consumer_code=\'B\'
                              and a.visit_type_code=\'R\'
                              group by
                              a.primary_site_id
                              ;'))
Retaildata=Retaildata[,-1]

#function to convert binary matrix to transactional data
bi<-function(r){
  x=names(r)[0]
  for (i in 1:length(r))
    if(r[i]>0) {x=paste(names(r)[i],x, sep=",")}
  return(substr(x,1,nchar(x)-1))}

#apply the function to the whole dataset

a=apply(Retaildata,1,sum)
which(a==0)
Retaildata=Retaildata[-which(a==0),]

m=apply(Retaildata,1,bi)


library(arules)
write.table(m,"try19.csv",row.names = F,col.names=F,quote = FALSE)
groc<-read.transactions("try19.csv",sep=',')
summary(groc)
write.csv(sort(itemFrequency(groc),decreasing=TRUE),"fre_item.csv")
?sort

#create dashboard
library('devtools')
install_github('brooksandrew/Rsenal')
library('Rsenal')
?Rsenal::arulesApp
arulesApp(groc,supp=0.001,conf=0.5)

dev.off()
#frequency plot
itemFrequencyPlot(groc,topN=20,support=0.01,type='relative') #Item frequency

rules<-apriori(groc,parameter = list(support=0.001,confidence=0.5, minlen=2))

rules1<-as(rules,"data.frame")
write.csv(rules1,"business_retail_exclude.csv")
#find frequent itemsets

itemsets <- unique(generatingItemsets(rules))
inspect(itemsets)[1]
itemsets.df <- as(itemsets, "data.frame")
frequentItemsets <- itemsets.df[with(itemsets.df, order(-support,items)),]
names(frequentItemsets)[1] <- "itemset"
write.table(frequentItemsets, file = "frequentItemsets_business_retail.csv", sep = ",", row.names = FALSE)

#write out rules to csv
rules1=as(rules,"data.frame")
write.csv(rules1,"Consumer_dotcom.csv")


#find the number of people in two basket
retaildata=Retaildata
#how many only use 4 copying product
retaildata=retaildata[,-which(names(retaildata) %in% c("Binding Services","Cutting & Drilling Services","Full Serve B&W Copying","Full Serve Color Copying","USPS","Self Serve B&W Copying","Self Serve Color Copying","Faxing", "Scanning", "Computer Workstation"))]
b=apply(retaildata, 1, sum)
length(which(b==0))
retaildata1=Retaildata[which(b!=0),] #extra customer buy other than copy/print products
m1=apply(retaildata1,1,bi)
write.table(m1,"try14.csv",row.names = F,col.names=F,quote = FALSE)
groc1<-read.transactions("try14.csv",sep=',')
summary(groc1)
sort(itemFrequency(groc1),decreasing=TRUE) #Item frequency

#what's their buying behavior for customer buying these 16 product other than copy& printing product?
#Do they also use dotcom
retaildata2=Retaildata
retaildata2=retaildata2[,which(names(retaildata2) %in% c('In House Cards & Invitations',
                                                         'In House Brochures',
                                                         'In House Posters',
                                                         'Business Services Resale Merch',
                                                         'In House Business Cards',
                                                         'In House Flyers',
                                                         'In House Postcards',
                                                         'In House Signs & Banners',
                                                         'Direct Mail Services',
                                                         'In House S&B Finsihing',
                                                         'In House Signs/Displays',
                                                         '3rd Party Bus Cards',
                                                         '3rd Party Promo Printing',
                                                         '3rd Party Postcards',
                                                         '3rd Party Custom Stamps',
                                                         '3rd Party Engr Sign&Badge',
                                                         'Third Party Brochures',
                                                         'In House Brother Stamp',
                                                         '3rd Party Signs/Displays',
                                                         'Photo Gifts',
                                                         'Staples Promotional Products',
                                                         '3rd Party Cards & Invitations',
                                                         '3rd Party Calendars',
                                                         'Branding/Design Services'))]
c=apply(retaildata2, 1, sum)
length(which(c!=0))
retaildata2=retaildata2[which(c!=0),]
m2=apply(retaildata2,1,bi)
write.table(m2,"try22.csv",row.names = F,col.names=F,quote = FALSE)
groc1<-read.transactions("try22.csv",sep=',')
summary(groc1)
rules<-apriori(groc1,parameter = list(support=0.001,confidence=0.5, minlen=2))
rules1<-as(rules,"data.frame")
write.csv(rules1,"mkt_user_rules.csv")

retaildata3=retaildata2[,-which(names(retaildata2) %in% c('3rd Party Bus Cards'))]
d=apply(retaildata3, 1, sum)
length(which(d==0))


library('devtools')
install_github('brooksandrew/Rsenal')
library('Rsenal')
?Rsenal::arulesApp
arulesApp(groc1,supp=0.001,conf=0.5)

write.csv(itemFrequency(groc1),"item_fre_business_retail_mkt_solution.csv")
itemFrequency(groc1,topN=10,support=0.001,type='relative')
itemsets <- unique(generatingItemsets(rules))
inspect(itemsets)[1]
itemsets.df <- as(itemsets, "data.frame")
frequentItemsets <- itemsets.df[with(itemsets.df, order(-support,items)),]
names(frequentItemsets)[1] <- "itemset"
write.table(frequentItemsets, file = "frequentItemsets_consumer_retail_prospect.csv", sep = ",", row.names = FALSE)



#create static plots
library(arulesViz)
rules<-apriori(groc1,parameter = list(support=0.005,confidence=0.5, minlen=2))
plot(rules, method = NULL, measure = "support", shading = "lift",
     + interactive = FALSE, data = NULL, control = NULL, ...)
subrules <- rules[quality(rules)$confidence > 0.8]
subrules2 <- head(sort(rules, by="lift"), 10)
plot(rules,method=NULL,measure = "support",shading = 'lift',interactive = FALSE,data=NULL,control=NULL)
plot(subrules)
plot(rules, method="graph")
plot(rules,method="graph", control=list(type="itemsets"))
plot(rules, method="paracoord")
plot(rules, method="paracoord", control=list(reorder=TRUE))





################################################################################################
library(RODBC)
ch <- odbcConnect(dsn = "PRD_MKTG_BIV", uid = "LiXi001", pwd = "temp1234")

#Retailxconsumer
Retaildata=sqlQuery(ch, paste('select a.primary_site_id
                              , SUM(case when class_id = 298 then 1 else 0 end) as "Copy Center Misc"
                              , SUM(case when class_id = 408 then 1 else 0 end) as "FedEx"
                              , SUM(case when class_id = 409 then 1 else 0 end) as "Packing Services"
                              , SUM(case when class_id = 410 then 1 else 0 end) as "Third Party Posters"
                              , SUM(case when class_id = 411 then 1 else 0 end) as "Third Party Banners"
                              , SUM(case when class_id = 412 then 1 else 0 end) as "Color Engineering Prints"
                              , SUM(case when class_id = 413 then 1 else 0 end) as "Third Party Flyers"
                              , SUM(case when class_id = 414 then 1 else 0 end) as "Makr"
                              , SUM(case when class_id = 415 then 1 else 0 end) as "Photo Printing"
                              , SUM(case when class_id = 456 then 1 else 0 end) as "UNASSIGNED BUSINESS SERVI"
                              , SUM(case when class_id = 471 then 1 else 0 end) as "PTO/STEP Core Print"
                              , SUM(case when class_id = 472 then 1 else 0 end) as "Banner Accessories"
                              , SUM(case when class_id = 474 then 1 else 0 end) as "Labels"
                              , SUM(case when class_id = 475 then 1 else 0 end) as "Outsource Custom Print"
                              , SUM(case when class_id = 476 then 1 else 0 end) as "PTO/STEP Custom Print"
                              , SUM(case when class_id = 477 then 1 else 0 end) as "Outsource Wide Format"
                              , SUM(case when class_id = 479 then 1 else 0 end) as "PTO/STEP Wide Format"
                              , SUM(case when class_id = 482 then 1 else 0 end) as "Web & Digital Services"
                              , SUM(case when class_id = 484 then 1 else 0 end) as "In House Photobooks"
                              , SUM(case when class_id = 485 then 1 else 0 end) as "In House Cards & Invitations"
                              , SUM(case when class_id = 496 then 1 else 0 end) as "In House Brochures"
                              , SUM(case when class_id = 497 then 1 else 0 end) as "Canvas Prints"
                              , SUM(case when class_id = 498 then 1 else 0 end) as "In House Posters"
                              , SUM(case when class_id = 600 then 1 else 0 end) as "Business Services Resale Merch"
                              , SUM(case when class_id = 601 then 1 else 0 end) as "In House Business Cards"
                              , SUM(case when class_id = 602 then 1 else 0 end) as "In House Flyers"
                              , SUM(case when class_id = 603 then 1 else 0 end) as "In House Postcards"
                              , SUM(case when class_id = 604 then 1 else 0 end) as "In House Signs & Banners"
                              , SUM(case when class_id = 605 then 1 else 0 end) as "Direct Mail Services"
                              , SUM(case when class_id = 606 then 1 else 0 end) as "In House Calendars"
                              , SUM(case when class_id = 607 then 1 else 0 end) as "Computer Workstation"
                              , SUM(case when class_id = 608 then 1 else 0 end) as "In House Other"
                              , SUM(case when class_id = 609 then 1 else 0 end) as "Self Serve Color Copying"
                              , SUM(case when class_id = 610 then 1 else 0 end) as "Full Serve Color Copying"
                              , SUM(case when class_id = 611 then 1 else 0 end) as "Self Serve B&W Copying"
                              , SUM(case when class_id = 612 then 1 else 0 end) as "Full Serve B&W Copying"
                              , SUM(case when class_id = 613 then 1 else 0 end) as "B&W Engineering Prints"
                              , SUM(case when class_id = 614 then 1 else 0 end) as "Binding Services"
                              , SUM(case when class_id = 615 then 1 else 0 end) as "Folding Services"
                              , SUM(case when class_id = 616 then 1 else 0 end) as "Cutting & Drilling Services"
                              , SUM(case when class_id = 617 then 1 else 0 end) as "Laminating"
                              , SUM(case when class_id = 618 then 1 else 0 end) as "In House S&B Finsihing"
                              , SUM(case when class_id = 619 then 1 else 0 end) as "In House Signs/Displays"
                              , SUM(case when class_id = 620 then 1 else 0 end) as "3rd Party Bus Cards"
                              , SUM(case when class_id = 621 then 1 else 0 end) as "3rd Party Bus Letterhead"
                              , SUM(case when class_id = 622 then 1 else 0 end) as "3rd Party Promo Printing"
                              , SUM(case when class_id = 623 then 1 else 0 end) as "3rd Party Bus Envelopes"
                              , SUM(case when class_id = 624 then 1 else 0 end) as "3rd Party Carbonless Form"
                              , SUM(case when class_id = 625 then 1 else 0 end) as "3rd Party Postcards"
                              , SUM(case when class_id = 626 then 1 else 0 end) as "3rd Party Check Printing"
                              , SUM(case when class_id = 627 then 1 else 0 end) as "3rd Party Other"
                              , SUM(case when class_id = 628 then 1 else 0 end) as "3rd Party Label Printing"
                              , SUM(case when class_id = 629 then 1 else 0 end) as "Paper Upgrades"
                              , SUM(case when class_id = 630 then 1 else 0 end) as "3rd Party Custom Stamps"
                              , SUM(case when class_id = 631 then 1 else 0 end) as "3rd Party Engr Sign&Badge"
                              , SUM(case when class_id = 632 then 1 else 0 end) as "Third Party Brochures"
                              , SUM(case when class_id = 633 then 1 else 0 end) as "In House Brother Stamp"
                              , SUM(case when class_id = 634 then 1 else 0 end) as "3rd Party Signs/Displays"
                              , SUM(case when class_id = 635 then 1 else 0 end) as "Full Service Labor"
                              , SUM(case when class_id = 636 then 1 else 0 end) as "Tests"
                              , SUM(case when class_id = 639 then 1 else 0 end) as "Photo Gifts"
                              , SUM(case when class_id = 640 then 1 else 0 end) as "Staples Promotional Products"
                              , SUM(case when class_id = 641 then 1 else 0 end) as "3rd Party Cards & Invitations"
                              , SUM(case when class_id = 642 then 1 else 0 end) as "3rd Party Calendars"
                              , SUM(case when class_id = 643 then 1 else 0 end) as "Outsource Core Print"
                              , SUM(case when class_id = 650 then 1 else 0 end) as "Shredding"
                              , SUM(case when class_id = 651 then 1 else 0 end) as "Full Serve Fees"
                              , SUM(case when class_id = 652 then 1 else 0 end) as "Scanning"
                              , SUM(case when class_id = 653 then 1 else 0 end) as "3D Printing Services"
                              , SUM(case when class_id = 654 then 1 else 0 end) as "Branding/Design Services"
                              , SUM(case when class_id = 660 then 1 else 0 end) as "Faxing"
                              , SUM(case when class_id = 671 then 1 else 0 end) as "UPS/Purolator"
                              , SUM(case when class_id = 672 then 1 else 0 end) as "Dotcom 3rd Party Shipping"
                              , SUM(case when class_id = 673 then 1 else 0 end) as "USPS"
                              , SUM(case when class_id = 677 then 1 else 0 end) as "Contract DCS Proprietary"
                              , SUM(case when class_id = 678 then 1 else 0 end) as "Contract Print Proprietary"
                              , SUM(case when class_id = 679 then 1 else 0 end) as "Contract Test/Other"
                              from PRD_MKTG_BIV.SALES_VISIT_LINE a inner join PRD_MKTG_BIV.item b on a.item_id = b.item_id
                              where a.fiscal_yearmo between 201604 and 201609
                              and b.division_id = 6
                              and a.visit_line_type_code=\'TRNLIN\'
                              and a.identifiable_ind=\'Y\'
                              and a.business_consumer_code=\'B\'
                              and a.visit_type_code=\'D\'
                              group by
                              a.primary_site_id
                              ;'))
Retaildata=Retaildata[,-1]

#function to convert binary matrix to transactional data
bi<-function(r){
  x=names(r)[1]
  for (i in 2:length(r))
    if(r[i]>0) {x=paste(names(r)[i],x, sep=",") }
  return(x)}

#apply the function to the whole dataset
m=apply(Retaildata,1,bi)
m

library(arules)
write.table(m,"try5.csv",row.names = F,col.names=F,quote = FALSE)
groc<-read.transactions("try5.csv",sep=',')
summary(groc)


#create dashboard
library('devtools')
install_github('brooksandrew/Rsenal')
library('Rsenal')
?Rsenal::arulesApp
arulesApp(groc,supp=0.001,conf=0.5)

dev.off()
#frequency plot
itemFrequencyPlot(groc,topN=10,horiz=TRUE,support=0.01,type='relative') #Item frequency

rules<-apriori(groc,parameter = list(support=0.001,confidence=0.5, minlen=2))

#find frequent itemsets

itemsets <- unique(generatingItemsets(rules))
itemsets.df <- as(itemsets, "data.frame")
frequentItemsets <- itemsets.df[with(itemsets.df, order(-support,items)),]
names(frequentItemsets)[1] <- "itemset"
write.table(frequentItemsets, file = "", sep = ",", row.names = FALSE)

#write out rules to csv
rules1=as(rules,"data.frame")
write.csv(rules1,"Consumer_dotcom.csv")


#create static plots
library(arulesViz)
plot(rules, method = NULL, measure = "support", shading = "lift",
     + interactive = FALSE, data = NULL, control = NULL, ...)
subrules <- rules[quality(rules)$confidence > 0.8]
subrules2 <- head(sort(rules, by="lift"), 10)
plot(rules,method=NULL,measure = "support",shading = 'lift',interactive = FALSE,data=NULL,control=NULL)
plot(rules)
plot(rules, method="graph")
plot(rules,method="graph", control=list(type="itemsets"))
plot(rules, method="paracoord")
plot(rules, method="paracoord", control=list(reorder=TRUE))
