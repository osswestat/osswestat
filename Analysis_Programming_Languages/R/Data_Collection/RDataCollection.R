######################### R Data Collection ####################################
library(cranlogs)
library(tidyverse)

### load in R CRAN database

cran <- tools::CRAN_package_db()

### Rename Reverse Depends Category
colnames(cran)[63] <- "Reverse_Depends"

### selecting variables of interest
cran <- cran %>%
  select(Package, Version, Depends, License, Author, 
         Description, Maintainer, Title, URL, Reverse_Depends)

### Filtering for unique package names

cran <- cran %>%
  distinct(Package, .keep_all = T)



################## Collecting All-Time Downloads ###############################


### all time download counts up until May 3rd (Defining function)

get_downloads <- function(package_name){
  downloads <- cran_downloads(packages = package_name, from = "1900-05-03",
                              to = "2023-05-03")
  sum(downloads$count)
}


### Running a loop across all packages

Downloads <- vector()

for (i in cran$Package) {
  
  Downloads[i] <- get_downloads(i)
}  


### saving Downloads variable
cran$Downloads <- Downloads