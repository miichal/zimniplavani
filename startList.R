# by 2018 Michal Pohorely - michal@pohorely.cz
# start list generator

# reading data from zimni plavani
#install.packages("rlist")

library(XML)
library(RCurl)
library(rlist)


eventID<-c(3754:3777,4195)
baseURL<-"https://bodovani.zimni-plavani.info/soutez_vysl.php?id="
startList<-data.frame()

#download events data from web
fullurl<-GET("https://bodovani.zimni-plavani.info/souteze.php?rok=2017", mapunicode=FALSE)
theurl <- content(fullurl,"text")
#textURL<-content(urldata,"text")
tables <- readHTMLTable(theurl, header = TRUE, as.data.frame = TRUE)
#tables <- list.clean(tables, fun = is.null, recursive = FALSE)
#n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

#create data frame for swimmers and rank

#swimmers<-data.frame()

#convert table to dataframe and clean
events<-as.data.frame(tables[[1]])
events<-events[-c(1:5), ]

colnames(events)<-c("soutez","datum","popis","plavcu","oddilu")

events$soutez


#download event data from web

#eventID=3754
for (i in eventID){
  fullURL<-paste(baseURL,i,sep = "")
  theurl <- getURL(fullURL,.opts = list(ssl.verifypeer = FALSE) )
  tables <- readHTMLTable(theurl, header = TRUE, as.data.frame = TRUE)
  if (length(tables)!=4) next
  #tables <- list.clean(tables, fun = is.null, recursive = FALSE)
  #n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  
  #create data frame for swimmers and rank
  
  #swimmers<-data.frame()
  
  #convert table to dataframe and clean
  sw1<-as.data.frame(tables[[1]])
  sw1<-sw1[-c(1,3,4), ]
  sw1<-sw1[-c(nrow(sw1),nrow(sw1)-1,nrow(sw1)-2), ]
  
  colnames(sw1)<-c("umisteni","s.c.","jmeno","rocnik","oddil","VS","trat","charakter","cas","body")
  sw1<-sw1[-1, ]
  
  # creating start list for organizers
  
  #check maximum length of track and create subset
  maxTrat<-as.character(sw1$trat[1])
  maxTratList<-sw1[sw1$trat %in% maxTrat,]
  
  #typeof(sw1$cas)
  
  #extract just name and rank
  
  startList<-c(startList,list(maxTratList[,c("jmeno","umisteni","cas")]))
  
}





