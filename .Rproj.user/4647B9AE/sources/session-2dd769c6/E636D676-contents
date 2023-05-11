#
#
# Shiny Life-Like Cells: App (Main)
#
#



# Source -----------------------------------------------------------------------

setwd(paste0(getwd(), "/R"))  # Point to folder with R files
source("ui.R")
source("server.R")

# Create Shiny App -------------------------------------------------------------

#' Starts the App to Play With
#'
#' Run it to start the app and play around with the
#'    cellular automata.
#'
#' @param none There are no arguments!
#'
#' @return The app just starts. So, nothing is returned, I guess?
#'
#' @details For more details on cellular automata see the \href{https://en.wikipedia.org/wiki/Life-like_cellular_automaton}{Wikipedia article}.
#'
#' @examples
#' play()
#'
#' @export
play <- function() {
  shiny::shinyApp(ui = ui, server = server)
}
