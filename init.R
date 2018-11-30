#initial load of HTML data

#install.packages("rjson")

#load libraries
library(XML)
library(httr)


#assign URL
url <- 'https://bodovani.zimni-plavani.info/soutez_vysl.php?id='
index<-3754
tabulka<-list()
plavci<-list()
fullurl=paste(url,index)

#1. soutez Punkva - 3754
#posledni soutez Zarici - 3778

#nacti vsechny souteze sezony

for (index in 3754:3778){
  fullurl=paste(url,index)
  urldata<-GET(fullurl, mapunicode=FALSE)
  textURL<-content(urldata,"text")
  data <- readHTMLTable(textURL, 
                         stringsAsFactors = FALSE)
  tabulka<-append(tabulka,as.data.frame(data[3]))
}

#vytvor seznam plavcu v sezone
#krok<-seq(3,230,10)
for (index in seq(3,230,10)){
  plavci<-append(plavci,tabulka[[index]])
  
}

tplav<-t(plavci[])
plavci_df<-data.frame()
plavci_df<-as.data.frame(tplav)

#a1<-as.data.frame(tabulka)
#tabulka1<-as.data.frame(tabulka[3754])
#tabulka2<-tabulka1[ -c(2,6)]
#names(tabulka2)<-c('umisteni', 'jmeno', 'narozeni', 'trat', 'voda', 'cas', 'body')
#tabulka1[2]<-as.data.frame(data[3])

vplav<-unlist(plavci)
duplicated(vplav)
which (sapply(plavci[1][1], FUN=function(x) "Hrdý Zdeněk" %in% x))

uniplav<-vplav[-which(duplicated(vplav))]
