library(shiny)

# server.R
# server.R

library(maps)
library(mapproj)
counties <- readRDS("data/counties.rds")
source("helpers.R")

shinyServer(
  function(input, output) {
    output$map <- renderPlot({
      data <- switch(input$var, 
                     "Percent White" = counties$white,
                     "Percent Black" = counties$black,
                     "Percent Hispanic" = counties$hispanic,
                     "Percent Asian" = counties$asian)
      title <- switch(input$var,
                      "Percent White" = "%White",
                      "Percent Black" = "%Black",
                      "Percent Hispanic" = "Hispanic",
                      "Percent Asian" = "Asian")
      color<-switch (input$var,
                     "Percent White" = "darkgreen",
                     "Percent Black" = "black",
                     "Percent Hispanic" = "darkorange",
                     "Percent Asian" = "darkviolet")

      
      percent_map(var = data, color = color, legend.title = title, max = input$range[2], min = input$range[1])
    })
  }
)