# data to map
gdhi_per_head <- read.csv("../../Data/Regional household income/gdhireferencetables-table2-nuts3.csv", 
                          header = T) 

# join data
mapdata <- nuts3_ugc
mapdata@data <- left_join(mapdata@data, 
                          gdhi_per_head, 
                          by=c("nuts318cd" = "NUTS.code") )

# inspect data and set bins
# boxplot(gdhi_per_head$X2016)
bins <- c(seq(10000,30000,5000), 60000)
pal <- colorBin("YlOrRd", domain = gdhi_per_head$X2016, bins = bins)

# labels
labels <- sprintf("%s <br> &pound;%g per head", 
                  mapdata$nuts318nm, 
                  mapdata$X2016) %>% 
  lapply(htmltools::HTML)

# map
leaflet(mapdata) %>% 
  addPolygons(fillColor = ~pal(X2016), 
              weight = 1, 
              opacity = 1, 
              color = "white", 
              fillOpacity=0.7, 
              label = labels) %>% 
  addLegend(pal = pal, values = ~X2016, title = "GDHI per head (&pound;), NUTS3 areas",
            position = "bottomleft", opacity = 0.7)

