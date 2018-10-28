# by 2018 Michal Pohorely - michal@pohorely.cz
# start list generator

# reading data from zimni plavani
#install.packages("rlist")

library(XML)
library(RCurl)
library(rlist)


theurl <- getURL("https://bodovani.zimni-plavani.info/soutez_vysl.php?id=3755",.opts = list(ssl.verifypeer = FALSE) )
tables <- readHTMLTable(theurl, header = TRUE, as.data.frame = TRUE)
#tables <- list.clean(tables, fun = is.null, recursive = FALSE)
#n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

#create data frame for swimmers and rank

swimmers<-data.frame()

sw1<-as.data.frame(tables[[1]])
sw1<-sw1[-c(1,3,4), ]
colnames(sw1)<-as.character(unlist(sw1[1, ]))

sw1<-sw1[-1, ]

# creating start list for organizers

