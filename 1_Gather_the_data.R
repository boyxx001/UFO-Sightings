#To take a look at the states I have available to me:
library(XML)
library(tidyverse)
library(stringr)
library(lubridate)

loc_url <- "http://www.nuforc.org/webreports/ndxloc.html"

states <- readHTMLTable(loc_url, which=1)

write.csv(states,"states_ufo.csv")

head(states)
 

#List of Links
state_links <- htmlParse(loc_url) %>% 
  xpathSApply(.,"//a/@href") %>% 
  as_data_frame() %>% 
  filter(row_number() > 2)

head(state_links)

  
#dataframe to append all the results to
sightings <- data_frame()

#Base Url to compose the first bit of the URLs to loop through
base_url <- "http://www.nuforc.org/webreports/"

for (i in seq(nrow(state_links))) {
  
  link <- state_links[i,1]
  
     u <- paste(base_url, link, sep = "")
     
  temp <- readHTMLTable(u, which = 1) %>% 
      as_data_frame()
  
  sightings <- bind_rows(sightings, temp)
  
  print(paste(round(i/nrow(state_links),4)*100,"%"))
  
}



  

