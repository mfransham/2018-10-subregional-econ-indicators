# data to map
gradjobs_res <- read.csv("../2018-09-geography-of-grad-jobs/grads-ttwa.csv", 
                         header = T) 

# join data
mapdata <- ttwa2011_ugc
mapdata@data <- left_join(mapdata@data, 
                          gradjobs_res, 
                          by=c("ttwa11cd" = "TTWA11CD") )

# inspect data and set bins
summary(gradjobs_res$grad_jobs_pc)
bins <- seq(15,45,5)
pal <- colorBin("YlOrRd", domain = gradjobs_res$grad_jobs_pc, bins = bins)

# labels
labels <- sprintf("%s <br> %g%%", 
                  mapdata$ttwa11nm, 
                  mapdata$grad_jobs_pc) %>% 
  lapply(htmltools::HTML)

# map
leaflet(mapdata) %>% 
  # addTiles() %>% 
  # addProviderTiles("CartoDB.Positron") %>% 
  addPolygons(fillColor = ~pal(grad_jobs_pc), 
              weight = 1, 
              opacity = 1, 
              color = "white", 
              fillOpacity=0.7, 
              label = labels) %>% 
  addLegend(pal = pal, 
            values = ~grad_jobs_pc, 
            title = "Graduate jobs (% of all in employment, <br> by residence), TTWAs",
            position = "bottomleft", opacity = 0.7)

