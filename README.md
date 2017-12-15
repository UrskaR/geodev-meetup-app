# sample Shiny app

First, you need to install the packages using the code below.
```
install.packages(c("shinydashboard", "leaflet", "rsconnect"))
```      
In order to build the app I recommend uncommenting chunks of code step by step. After each step you can run the app to see what you have done.   

We already have ```leafletOutput("map") ``` in the dashboardBody on the UI side and
```output$map <- renderLeaflet({ leaflet() %>% addTiles() })``` on the server side of the app.  

Now we want the map to fill the screen. We can achieve that through some custom CSS.

Uncommenting the code in the ```dashboardBody()``` does just that.

```
tags$style(type = "text/css", "#map {height: 100% !important;}"),

  div(class="outer",
      tags$head(
        # Include  custom CSS
        includeCSS("styles.css")
      ),
      leafletOutput("map")
  )
```  

Then we will modify leaflet map with different provider tiles, we will add mini map and locate user button. We need to uncomment the code on server side. Be sure to comment the ```addTiles()``` line.  

When done, the code should match the code below.

```
output$map <- renderLeaflet({
    leaflet() %>% 
      # addTiles() # adds default tiles (comment this line when using code below)
      addProviderTiles(provider = providers$Stamen.Terrain) %>% # adds provider tiles
      setView(lng = 14.815333, lat = 46.119944, zoom = 7) %>% # sets the default view of the map
      addMiniMap( # adds MiniMap
        tiles = providers$OpenStreetMap,
        toggleDisplay = TRUE) %>%
      addEasyButton(easyButton( # Adds Locate Me button
        icon="fa-crosshairs", title="Locate Me",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  })
```  

We will now add functionality that enables user to add markers to map. Finally we will add a button that, when pressed, removes markers.  

The ```observeEvent()``` function does just that. It waits for the click event to happen and when it does it executes a code. Everything is done on the server side of the app.

```
# Add marker when one clicks on map
  observeEvent(input$map_click, {
    click <- input$map_click
    pnt <- data.frame(lat = click$lat, lng = click$lng)
    leafletProxy(mapId = "map", data = pnt) %>%
      addCircleMarkers(group = "markers", popup = paste(paste("lat:", click$lat, "lng:", click$lng, sep = " ")))
  })
```  

We will now add a button in the sidebar on the UI side.

```
sidebar <- dashboardSidebar(collapsed = TRUE,
                            sidebarMenu(
                              br(),
                              actionButton(inputId = "removeMarkers", label = "Remove markers", icon = icon("remove"), width = "85%")
                            )
)
```  

And add another ```observeEvent()``` that waits for the button to be clicked.

```
observeEvent(input$removeMarkers, {
    leafletProxy(mapId = "map") %>%
      clearMarkers()
  })
```  

If you successfuly uncommented all the lines, the app should be working as planned.  

You can now easily deploy the app using ```rsconnect::deployApp()```. Be sure to first create an account at [shinyapps.io](http://www.shinyapps.io/)




