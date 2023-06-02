#
#
# livelycells: Play
#
#



# Create Shiny App -------------------------------------------------------------

#' Starts the App to Play With
#'
#' Run this function to start the app in your browser and play the Game.
#'
#' @param none There are no arguments!
#'
#' @return The app just starts in your browser. So, nothing is returned, I guess?
#'
#' @details For more details on the Game see its \href{https://en.wikipedia.org/wiki/Conway's_Game_of_Life}{Wikipedia article}.
#'
#' @examples
#' play()
#'
#' @export
play <- function() {
  shiny::runApp(
    system.file("shiny", package = "livelycells"),
    display.mode = "normal",
    launch.browser = TRUE
  )
}
