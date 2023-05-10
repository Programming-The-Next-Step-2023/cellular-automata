#
#
# Shiny Life-Like Cells: UI
#
# sourced and used in app.R



# Import and source ------------------------------------------------------------

library(shiny)


# UI ---------------------------------------------------------------------------

ui <- fluidPage(
  
  # Title ----
  titlePanel("Life-Like Cells"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for rules ----
      selectInput(
        inputId = "rule",
        label = "Rule Set",
        choices = c("Life",
                    "Life without Death",
                    "Seeds",
                    "Replicator")
      )
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
    )
    
  )
  
) # end UI

