if (!require("twitteR")){
  install.packages("twitteR", repos="http://cran.rstudio.com/")
  library("twitteR")
}

consumer_key <- "b35qDXN6VvNpsxnqoFTDDll6U"
consumer_secret <- "uux9vLwKAXhaJuNJRajcu8DOCvn0LhdxRwHE0m62y3eUZTJpLv"
access_token <- "14701057-9LHglQUPDoOJ55qaMhHTBfA91IhBuZkCloPl4iMHE"
access_secret <- "a7qoTjOGe4OqwB9mg01bwmkqw7yvR5BCXohEYqxh2hTv7"
options(httr_oauth_cache=T) #enables use of local file to cache OAuth credentials
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)


lucaspuente <- getUser("lucaspuente")
location(lucaspuente)

lucaspuente_follower_IDs <- lucaspuente$getFollowers(retryOnRateLimit=180)

length(lucaspuente_follower_IDs)

if (!require("data.table")){
  install.packages("data.table", repos="http://cran.rstudio.com/")
  library("data.table")
}
lucaspuente_followers_df = rbindlist(lapply(lucaspuente_follower_IDs, as.data.frame))

head(lucaspuente_followers_df$location, 10)

lucaspuente_followers_df <- subset(lucaspuente_followers_df, location!="")

lucaspuente_followers_df$location <- gsub("%", " ", lucaspuente_followers_df$location)

if (source == "google"){
  url_string <- paste("https://maps.googleapis.com/maps/api/geocode/json?address=", posturl, "&key=", api_key, sep="")
}

source("https://raw.githubusercontent.com/LucasPuente/geocoding/master/geocode_helpers.R")

source("https://raw.githubusercontent.com/LucasPuente/geocoding/master/modified_geocode.R")

geocode_apply <- function(x){
  geocode(x, source="google", output="all", api_key=[INSERT GOOGLE API])
}

geocode_results <- sapply(lucaspuente_followers_df$location, geocode_apply, simplify=F)

length(geocode_results)

condition_a <- sapply(geocode_results, function(x) x["status"]=="OK")
geocode_results <- geocode_results[condition_a]

condition_b <- lapply(geocode_results, lapply, length)
condition_b2 <- sapply(condition_b, function(x) x["results"]=="1")
geocode_results <- geocode_results[condition_b2]
length(geocode_results)

source("https://raw.githubusercontent.com/LucasPuente/geocoding/master/cleaning_geocoded_results.R")

results_b <- lapply(geocode_results, as.data.frame)

results_c <- lapply(results_b, function(x) subset(x, select=c("results.formatted_address",
                                                              "results.geometry.location")))

results_d <- lapply(results_c, function(x) data.frame(Location=x[1, "results.formatted_address"],
                                                      lat=x[1, "results.geometry.location"],
                                                      lng=x[2, "results.geometry.location"]))

results_e <- rbindlist(results_d)

results_f <- results_e[,Original_Location:=names(results_d)]

american_results <- subset(results_f,
                           grepl(", USA", results_f$Location)==TRUE)

head(american_results,5)

american_results$commas <- apply(american_results$Location, function(x)
  length(as.numeric(gregexpr(",", as.character(x))[[1]])))
american_results <- subset(american_results, commas==2)
#Drop commas column
american_results <- subset(american_results, select=-commas)

nrow(american_results)

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% install.packages()[,"Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies=TRUE, repos="http://cran.rstudio.com/")
  sapply(pkg, require, character.only = TRUE)
}
packages <- c("map", "mapproj")
ipak(packages)

#generate blank map:
albers_proj <- map("state", proj="albers", param=c(39,45),
                   col="#9999999", fill=FALSE, bg=NA, lwd=0.2, add=FALSE, resolution=1)
#add points to it
points(mapproject(american_results$lng, american_results$lat), col=NA, bg="#00000030", pch=21, cex=1.0)

#add a title
mtext("The Geography of @LucasPuente's Followers", side=3, line=-3.5, outer=T, cex=1.5, font=3)