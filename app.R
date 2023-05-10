#
#
# Shiny Life-Like Cells: App (Main)
#
#



# Import and source ------------------------------------------------------------

library(shiny)

source("ui.R")
source("server.R")


# Create Shiny App -------------------------------------------------------------

shinyApp(ui = ui, server = server)
