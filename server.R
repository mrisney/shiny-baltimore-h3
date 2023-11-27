library(shiny)
library(leaflet)
library(h3jsr)
library(sf)

server <- function(input, output) {
  
  output$map <- renderLeaflet({
    # Central coordinates for Baltimore
    lat <- 39.2904
    lng <- -76.6122
    
    # Get H3 resolution and opacity from input
    resolution <- input$resolution
    opacity <- input$opacity
    
    # Define a bounding box around the central point in Baltimore
    bbox <- st_as_sfc(st_bbox(c(xmin = lng - 0.1, xmax = lng + 0.1, 
                                ymin = lat - 0.1, ymax = lat + 0.1), crs = 4326))
    
    # Generate H3 indexes for this bounding box at the selected resolution
    h3_indexes <- polygon_to_cells(bbox, res = resolution)
    
    # Initialize Leaflet map centered on Baltimore
    leaflet_map <- leaflet() %>%
      addTiles() %>%
      setView(lng = lng, lat = lat, zoom = 12)
    
    # Add each hexagon to the map with the specified opacity
    for (index in h3_indexes) {
      hex_boundary <- cell_to_polygon(index)  # Convert H3 index to polygon
      
      leaflet_map <- leaflet_map %>%
        addPolygons(data = hex_boundary,
                    fillColor = "blue",
                    fillOpacity = opacity,
                    color = "black",
                    weight = 1)
    }
    
    # Return the map
    leaflet_map
  })
}
