# by 2018 Michal Pohorely - michal@pohorely.cz
# start list generator

# reading data from zimni plavani
install.packages("rlist")
library(XML)
library(RCurl)
library(rlist)
theurl <- getURL("https://bodovani.zimni-plavani.info/soutez_vysl.php?id=3754",.opts = list(ssl.verifypeer = FALSE) )
tables <- readHTMLTable(theurl)
tables <- list.clean(tables, fun = is.null, recursive = FALSE)
n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

# creating start list for organizers

