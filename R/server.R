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
  border_reached <- reactiveVal(FALSE)  # only backend
  still_life <- reactiveVal(FALSE)  # only frontend

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

          if (all.equal(current_dish, next_dish) == TRUE) {
            still_life(TRUE)
          }

          generation_counter(generation_counter() + 1)
          petri_dish(next_dish)

        } else {  # Border IS reached
          automaton_running(FALSE)
        }



      } else {  # Automaton NOT running
        NULL
      }

    })  # End automaton
  })    # End automaton



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
      if (sum(petri_dish()) != 0) {  # only starts if there are living cells
        automaton_running(TRUE)
      }
    }
  )

  shiny::observeEvent(
    input$stop_button,
    {
      automaton_running(FALSE)
      still_life(FALSE)
    }
  )

  shiny::observeEvent(
    input$kill_button,
    {
      automaton_running(FALSE)
      border_reached(FALSE)
      still_life(FALSE)
      generation_counter(0)
      killed_dish <- petri_dish()
      killed_dish[killed_dish == 1] <- 0
      petri_dish(killed_dish)
    }
  )

  # Plot output ----
  output$shown_plot <- renderPlot({
    draw_pixels(petri_dish())
  })


  # User info ----
  output$user_info <- shiny::renderText({

    if (automaton_running() == FALSE) {

      # Check for border cells
      # was easier to implement this way than via backend border_reached()
      current_dish <- petri_dish()
      if (
        sum(current_dish[1, ]) > 0 ||
        sum(current_dish[nrow(current_dish), ]) > 0 ||
        sum(current_dish[, 1]) > 0 ||
        sum(current_dish[, ncol(current_dish)]) > 0
      ) {
        "🚨 There are cells at the border which this app can´t simulate. Kill those border cells by mouse or kill all cells ⚰️."
      } else if (sum(petri_dish()) == 0) {
        "💡 There are no living cells. Use your mouse to click some to life!"
      } else {
        "😴 the cells are sleeping"
      }

    } else {  # Automaton IS running

      if (sum(petri_dish()) == 0) {
        "🪦 All cells died out throughout the evolution. Start over with ⚰️."
      } else if (still_life() == TRUE) {
        "🧘 This is a still life. The evolution continues but the cells found inner peace."
      } else {
        "🥳 Watch, the cells are lively and evolving!"
      }

    }

  })  # End user info


  output$coder_info <- shiny::renderPrint({
    cat("coder_info | ", "running: ", automaton_running(),
        " border: ", border_reached(),
        " still life: ", still_life())
  })


  output$current_generation <- shiny::renderText({
    paste0("Generation: ", generation_counter())
  })

  output$current_population <- shiny::renderText({
    paste0("Population: ", sum(petri_dish()))
  })

}
