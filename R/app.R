#
#
# Shiny Life-Like Cells: App (Main)
#
#



# Create Shiny App -------------------------------------------------------------

#' Starts the App to Play With
#'
#' Run it to start the app and play the Game
#'
#' @param none There are no arguments!
#'
#' @return The app just starts. So, nothing is returned, I guess?
#'
#' @details For more details on the Game see its \href{https://en.wikipedia.org/wiki/Conway's_Game_of_Life}{Wikipedia article}.
#'
#' @examples
#' play()
#'
#' @export
play <- function() {
  shinyApp(ui = ui, server = server)
}
