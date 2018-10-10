#####################################
# code file contents
#####################################

# code blocks


# render using the information stored in the current session
rmarkdown::render("subregional-indicators.Rmd", 
                  output_format = bookdown::html_document2() )
