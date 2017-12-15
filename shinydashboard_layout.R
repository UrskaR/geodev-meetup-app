# this is a layout that creates dashboard page

library(shinydashboard)

header <- dashboardHeader()

sidebar <- dashboardSidebar()

body <- dashboardBody()

ui <- dashboardPage(header, sidebar, body)


server <- function(input, output) { }

shinyApp(ui, server)
