#
#
# Shiny Life-Like Cells: Server
#
# Sourced and used in app.R



# Source -----------------------------------------------------------------------

source("./R/computations.R")
source("./R/pixeltrix.R")



# Server -----------------------------------------------------------------------

server <- function(input, output, session) {

  # Initial Settings ----
  automaton_running <- reactiveVal(FALSE)
  border_reached <- reactiveVal(FALSE)

  generation_counter <- reactiveVal(0)

  petri_dish <- reactiveVal(matrix(0, nrow = 50, ncol = 86))

  rules = "B3/S23"

  # Automaton ----
  shiny::observe({

    shiny::invalidateLater(800, session)
    shiny::isolate({

      if(automaton_running() == TRUE) {
        current_dish <- petri_dish()
        next_dish = evolve(current_dish, rules)[[1]]
        border_reached(evolve(current_dish, rules)[[2]])
        if(border_reached() == FALSE) {
          generation_counter(generation_counter() + 1)
          petri_dish(next_dish)
        }
      }  # End automaton

      else {
        NULL
      } # End point and click

    })
  })

  # Click Observe ----
  shiny::observeEvent(
    input$plot_click,
    {
      if (automaton_running() == FALSE) {
        next_dish <- petri_dish()
        indices = click_to_cell(next_dish, input$plot_click$x, input$plot_click$y)
        row_index = indices[[1]]
        col_index = indices[[2]]
        if (next_dish[row_index, col_index] == 0) {
            next_dish[row_index, col_index] <- 1
        } else {
            next_dish[row_index, col_index] <- 0
        }
        petri_dish(next_dish)
      }
    }
  )

  # Button Observers ----
  shiny::observeEvent(
    input$start_button,
    {
      automaton_running(TRUE)
    }
  )

  shiny::observeEvent(
    input$stop_button,
    {
      automaton_running(FALSE)
    }
  )

  shiny::observeEvent(
    input$kill_button,
    {
      border_reached(FALSE)
      automaton_running(FALSE)
      generation_counter(0)
      killed_dish <- petri_dish()
      killed_dish[killed_dish == 1] <- 0
      petri_dish(killed_dish)
    }
  )


  # Output ----
  output$shown_plot <- renderPlot({
    draw_pixels(petri_dish())
  })

  output$user_info <- shiny::renderText({
    if(border_reached() == TRUE) {
      paste0("🚨 There are cells at the border.")
    } else {
      if(automaton_running() == FALSE) {
        if (sum(petri_dish() == 0)) {
          paste0("💡 There are no living cells. Use your mouse to bring some to life!")
        } else {
          paste0("😴😴😴 the cells are sleeping 😴😴😴")
        }
      } else {
        paste0("🔎 Watch, those lively cells! They are evolving!")
      }

    }
  })

  output$current_generation <- shiny::renderText({
    paste0("Generation: ", generation_counter())
  })

  output$current_population <- shiny::renderText({
    paste0("Population: ", sum(petri_dish()))
  })

  # output$submitted_arguments <- shiny::renderText({
  #   paste("current rules: ", rule_string(), "current speed: " , speed())
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
