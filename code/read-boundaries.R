# read boundaries
nuts3_ugc <- geojsonio::geojson_read("https://opendata.arcgis.com/datasets/473aefdcee19418da7e5dbfdeacf7b90_4.geojson", 
                                     what="sp")
la2017_ugc <- geojsonio::geojson_read("https://opendata.arcgis.com/datasets/fab4feab211c4899b602ecfbfbc420a3_4.geojson", 
                                      what="sp")
ttwa2011_ugc <- geojsonio::geojson_read("https://opendata.arcgis.com/datasets/d3062ec5f03b49a7be631d71586cac8c_4.geojson", 
                                        what="sp")
