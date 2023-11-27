library(shiny)
library(leaflet)

# UI layout
ui <- fluidPage(
  titlePanel("H3 Hexagons on Leaflet Map in Baltimore"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("resolution",
                  "H3 Resolution:",
                  min = 0,
                  max = 15,
                  value = 9),  # Default resolution
      
      # Slider for hexagon transparency
      sliderInput("opacity",
                  "Hexagon Transparency:",
                  min = 0,
                  max = 1,
                  value = 0.5,  # Default transparency
                  step = 0.1)
    ),
    
    mainPanel(
      leafletOutput("map")  # Output where the map will be rendered
    )
  )
)
