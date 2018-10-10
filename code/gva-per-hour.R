# data to map
gva_per_hour <- read.csv("../../Data/Regional productivity/2018 subregional/1.tableA3.csv", 
                         header = T)

# join data
mapdata <- nuts3_ugc
mapdata@data <- left_join(mapdata@data, 
                          gva_per_hour, 
                          by=c("nuts318cd" = "NUTS.code") )

# inspect data and set bins
# boxplot(gva_per_hour$y2016)
bins <- seq(20,60,10)
pal <- colorBin("YlOrRd", domain = gva_per_hour$y2016, bins = bins)

# labels
labels <- sprintf("%s <br> &pound;%g per hour", 
                  mapdata$nuts318nm, 
                  mapdata$y2016) %>% 
  lapply(htmltools::HTML)

# map
leaflet(mapdata) %>% 
  addPolygons(fillColor = ~pal(y2016), 
              weight = 1, 
              opacity = 1, 
              color = "white", 
              fillOpacity=0.7, 
              label = labels) %>% 
  addLegend(pal = pal, values = ~y2016, title = "GVA per hour (&pound;), NUTS3 areas",
            position = "bottomleft", opacity = 0.7)

