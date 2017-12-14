library(shinydashboard)
library(leaflet)

header <- dashboardHeader(title = "geodev")

sidebar <- dashboardSidebar(collapsed = TRUE
                            # ,
                            # sidebarMenu(
                            #   br(),
                            #   actionButton(inputId = "removeMarkers", label = "Remove markers", icon = icon("remove"), width = "85%")
                            # )
)

body <- dashboardBody(
  # tags$style(type = "text/css", "#map {height: 100% !important;}"),
  # 
  # div(class="outer",
  #     tags$head(
  #       # Include  custom CSS
  #       includeCSS("styles.css")
  #     ),
      leafletOutput("map")
  # )
)

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
  output$map <- renderLeaflet({
    leaflet() %>% 
      addTiles() # add default tiles (comment this line when using code below)
      # addProviderTiles(provider = providers$Stamen.Terrain) %>%
      # setView(lng = 14.815333, lat = 46.119944, zoom = 7) %>%
      # addMiniMap(
      #   tiles = providers$OpenStreetMap,
      #   toggleDisplay = TRUE) %>%
      # addEasyButton(easyButton(
      #   icon="fa-crosshairs", title="Locate Me",
      #   onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  })
  # # Add marker when one clicks on map
  # observeEvent(input$map_click, {
  #   click <- input$map_click
  #   pnt <- data.frame(lat = click$lat, lng = click$lng)
  #   leafletProxy(mapId = "map", data = pnt) %>%
  #     addCircleMarkers(group = "markers", popup = paste(paste("lat:", click$lat, "lng:", click$lng, sep = " ")))
  # })
  # 
  # # Remove markers when button is pressed
  # observeEvent(input$removeMarkers, {
  #   leafletProxy(mapId = "map") %>%
  #     clearMarkers()
  # })
  
}

shinyApp(ui, server)
