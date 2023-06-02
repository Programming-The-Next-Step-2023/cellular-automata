#
#
# livelycells: Server
#
#



# Source redundant scripts for deployment --------------------------------------

# The following leads to conflicts/a warning when executing
# devtools::test()
# AFTER executing
# play()
# as server.R sources functions to the global environment
# with the same names as the livelycells functions.

# It was necessary to code it like that, because in order to
# deploy the app, shinyapps.io needs access to the livelycells library.

# However, livelycells is not on CRAN, so I had to source() instead of
# simply using
# library(livelycells)

# Here are three reasons why this is not a problem:

# 1)
# The app still works as intended.
# E.g., you can run play() multiple times
# and the hidden functions also continue to work.
# (There is only redundancy for the sake of deployment).

# 2)
# Testing usually happens before using.
# Thus, devtools::test() likely won´t raise a warning, since play()
# has not been executed yet.

# 3)
# Having executed play, you can simply run
# rm(list = c("click_to_cell", "draw_pixels", "evolve", "extract_rules",
# "neighbours"))
# to resolve these redundancies.
# I also added this command to the unit tests, so that testing twice
# does not raise a warning anymore.
# Unfortunatly, I was not able to incorporate it into the play() function
# so that it gets removed right again after being redundantly sourced.
# Also, unfortunately, I could not incorporate it into the unittest
# so that it works when executing devtools:test() for the first time after play().
source("redundant_4_deployment/scripts/pixeltrix.R")
source("redundant_4_deployment/scripts/computations.R")

load("redundant_4_deployment/data/butterfly.rda")
load("redundant_4_deployment/data/galaxy.rda")
load("redundant_4_deployment/data/gun.rda")
load("redundant_4_deployment/data/diehard.rda")
load("redundant_4_deployment/data/spaceship.rda")



# Server -----------------------------------------------------------------------

server <- function(input, output, session) {

  # Initial Settings ----
  petri_dish <- reactiveVal(matrix(0, nrow = 50, ncol = 86))
  automaton_running <- reactiveVal(FALSE)
  border_reached <- reactiveVal(FALSE)  # only backend
  still_life <- reactiveVal(FALSE)  # only frontend
  generation_counter <- reactiveVal(0)

  rules = "B3/S23"

  # Automaton ----
  observe({
    invalidateLater(800, session)
    isolate({

      if(automaton_running() == TRUE) {

        current_dish <- petri_dish()
        next_dish = evolve(current_dish, rules)[[1]]
        border_reached(evolve(current_dish, rules)[[2]])

        if(border_reached() == FALSE) {

          if (isTRUE(all.equal(current_dish, next_dish))) {
            still_life(TRUE)
          }

          if (sum(current_dish) > 0) {
            generation_counter(generation_counter() + 1)
          }

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
  observeEvent(
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
  observeEvent(
    input$start_button,
    {
      if (sum(petri_dish()) != 0) {  # only starts if there are living cells
        automaton_running(TRUE)
      }
    }
  )

  observeEvent(
    input$stop_button,
    {
      automaton_running(FALSE)
      still_life(FALSE)
    }
  )

  observeEvent(
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

  # Preset Patterns ----
  observeEvent(
    input$butterfly_button,
    {
      automaton_running(FALSE)
      border_reached(FALSE)
      still_life(FALSE)
      generation_counter(0)
      petri_dish(butterfly)
    }
  )

  observeEvent(
    input$galaxy_button,
    {
      automaton_running(FALSE)
      border_reached(FALSE)
      still_life(FALSE)
      generation_counter(0)
      petri_dish(galaxy)
    }
  )

  observeEvent(
    input$gun_button,
    {
      automaton_running(FALSE)
      border_reached(FALSE)
      still_life(FALSE)
      generation_counter(0)
      petri_dish(gun)
    }
  )

  observeEvent(
    input$diehard_button,
    {
      automaton_running(FALSE)
      border_reached(FALSE)
      still_life(FALSE)
      generation_counter(0)
      petri_dish(diehard)
    }
  )

  observeEvent(
    input$spaceship_button,
    {
      automaton_running(FALSE)
      border_reached(FALSE)
      still_life(FALSE)
      generation_counter(0)
      petri_dish(spaceship)
    }
  )

  observeEvent(
    input$random_button,
    {
      automaton_running(FALSE)
      border_reached(FALSE)
      still_life(FALSE)
      generation_counter(0)

      random_dish <- petri_dish()
      random_dish[random_dish == 1] <- 0

      for (row in 1:nrow(random_dish)) {
        for (col in 1:ncol(random_dish)) {

          if (
            (row > 15) &&
            (row < 35) &&
            (col > 30) &&
            (col < 56) &&
            (runif(1) > 0.8)
            ) {
            random_dish[row, col] = 1
          }

        }
      }

      petri_dish(random_dish)
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
        "🚨 There are cells at the border which this app cannot simulate. Kill these border cells by mouse or kill all cells ⚰️."
      } else if (sum(petri_dish()) == 0) {
        "💡 There are no live cells. Use your mouse to click some to life!"
      } else {
        "😴 the cells are sleeping"
      }

    } else {  # Automaton IS running

      if (sum(petri_dish()) == 0) {
        "🪦 All cells died out throughout the evolution. Start over with ⚰️."
      } else if (still_life()) {
        "🧘 This is a still life. The evolution continues but the cells found inner peace."
      } else {
        "🥳 Watch, the cells are lively and evolving!"
      }

    }

  })  # End user info

  output$current_generation <- shiny::renderText({
    paste0("Generation: ", generation_counter())
  })

  output$current_population <- shiny::renderText({
    paste0("Population: ", sum(petri_dish()))
  })

}
