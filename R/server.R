#
#
# Shiny Life-Like Cells: Server
#
# Sourced and used in app.R



# Source -----------------------------------------------------------------------

source("./R/computations.R")
source("./R/pixeltrix.R")
load("./data/test_matrices/big_glider.Rdata")


# Server -----------------------------------------------------------------------

server <- function(input, output, session) {

  # Initial Settings ----
  automaton_running <- reactiveVal(FALSE)
  generation_counter <- reactiveVal(0)

  petri_dish <- reactiveVal()  # There is only one reactive matrix
                               # so I choose this name
  petri_dish(big_glider)

  # Automaton ----
  rules = "B3/S23"
  speed = 750  # 1300, 1000, 750
  shiny::observe({

    shiny::invalidateLater(speed, session)
    shiny::isolate({
      if(automaton_running() == TRUE) {

        current_dish <- petri_dish()
        next_dish = evolve(current_dish, rules)[[1]]
        generation_counter(generation_counter() + 1)
        petri_dish(next_dish)


        # # Living border cells in CURRENT dish?
        # border_reached = evolve(current_dish, rules)[[2]]
        #
        # while (border_reached == FALSE) {
        #
        #   next_dish = evolve(current_dish, rules)[[1]]
        #
        #   # Living border cells in the NEXT dish?
        #   border_reached = evolve(current_dish, rules)[[2]]
        #   if (border_reached == TRUE) {
        #     break
        #   } else {
        #     petri_dish(next_dish)  # Update
        #     generation_counter(generation_counter() + 1)
        #   }
        # }



      } # End automaton
    }) # End automaton
  })  # End automaton


  # Button Observers ----
  shiny::observeEvent(
    input$start_button,
    {  # Code block that executes when start button is pressed
    automaton_running(TRUE)
  })

  shiny::observeEvent(
    input$stop_button,
    {
      automaton_running(FALSE)
    }
  )

  shiny::observeEvent(
    input$kill_button,
    {
      automaton_running(FALSE)
      generation_counter(0)
      killed_dish <- petri_dish()
      killed_dish[killed_dish == 1] <- 0
      petri_dish(killed_dish)
    }
  )


  # Output ----
  output$shown_plot <- renderPlot({
    draw_pixels(petri_dish())  # * 1.71 col
  })

  output$sleepy_lively <- shiny::renderText({
    if(automaton_running() == FALSE) {
      paste0("😴😴😴 the cells are sleeping 😴😴😴")
    } else {
      paste0("🔎 Watch, those lively cells!")
    }
  })

  output$current_generation <- shiny::renderText({
    paste0("Generation: ", generation_counter())
  })

  output$current_population <- shiny::renderText({
    paste0("Population: ", sum(petri_dish()))
  })


  # # Start button: Submit Automaton Settings ----
  # automaton_arguments <- eventReactive(input$start_button, {
  #   c(input$rules, input$evolution_speed, input$max_generations)
  # })
  # output$submitted_arguments <- shiny::renderText({
  #   paste("submitted:", automaton_arguments()[1],
  #         automaton_arguments()[2],
  #         automaton_arguments()[3])
  # })



  # # Reactive Output from Automaton Arguments ----
  # output$selected_rules <- shiny::renderText({
  #   paste0("reactive rules: ", input$rules)
  # })
  # output$evolution_speed <- shiny::renderText({
  #   paste0("reactive speed: ", input$evolution_speed)
  # })
  # output$max_generations <- shiny::renderText({
  #   paste0("reactive max_gen: ", input$max_generations)
  # })

}
