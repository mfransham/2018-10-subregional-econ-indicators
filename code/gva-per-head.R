# data to map
gva_per_head <- read.csv("../../Data/Regional gross value added/GVA-per-head-2016-LA.csv", 
                         header = T) 

# join data
mapdata <- la2017_ugc
mapdata@data <- left_join(mapdata@data, 
                          gva_per_head, 
                          by=c("lad17cd" = "LAU1.code") )

# inspect data and set bins
summary(gva_per_head$X2016)
bins <- c(seq(10000,50000,10000),Inf)
pal <- colorBin("YlOrRd", domain = gva_per_head$X2016, bins = bins)

# labels
labels <- sprintf("%s <br> &pound;%g", 
                  mapdata$lad17nm, 
                  mapdata$X2016) %>% 
  lapply(htmltools::HTML)

# map
leaflet(mapdata) %>% 
  # addTiles() %>% 
  # addProviderTiles("CartoDB.Positron") %>% 
  addPolygons(fillColor = ~pal(X2016), 
              weight = 1, 
              opacity = 1, 
              color = "white", 
              fillOpacity=0.7, 
              label = labels) %>% 
  addLegend(pal = pal, 
            values = ~X2016, 
            title = "GVA per head (&pound;), LA areas",
            position = "bottomleft", opacity = 0.7)

