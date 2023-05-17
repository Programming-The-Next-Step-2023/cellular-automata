#
#
#
# Shiny Life-Like Cells: Server
#
# sourced and used in app.R



# Source -----------------------------------------------------------------------



# Server -----------------------------------------------------------------------

server <- function(input, output) {

  # Start button: Submit Automaton Settings ----
  automaton_arguments <- eventReactive(input$start_button, {
    c(input$rules, input$evolution_speed, input$max_generations)
  })
  output$submitted_arguments <- shiny::renderText({
    paste("submitted:", automaton_arguments()[1],
          automaton_arguments()[2],
          automaton_arguments()[3])
  })

  # Reactive Output from Automaton Arguments ----
  output$selected_rules <- shiny::renderText({
    paste0("reactive rules: ", input$rules)
  })
  output$evolution_speed <- shiny::renderText({
    paste0("reactive speed: ", input$evolution_speed)
  })
  output$max_generations <- shiny::renderText({
    paste0("reactive max_gen: ", input$max_generations)
  })

}
