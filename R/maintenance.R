#
#
# Shiny Life-Like Cells: Maintenance
#
#

# This file is not used in the package.
# However, it can be useful for maintaining the package.

# The code here makes it possible to simulate
# cells in RStudio - without Shiny.
# This way it is possible to test and maintain smaller parts of the
# package without running the whole app.

# For example, once could improve the speed of the evolve function
# and then test it with automaton().



# Load test_matrices -----------------------------------------------------------

# test_matrices = as.list(dir(path = "./data/test_matrices"))
# for (i in 1:length(test_matrices)) {
#   file_path = paste0("./data/test_matrices/", test_matrices[i])
#   load(file_path)
# }



# automaton() ------------------------------------------------------------------

automaton <- function(input_matrix, rules, speed, max_iterations) {

  iteration = 0
  current_matrix = input_matrix

  # Living border cells in the INITIAL matrix?
  border_reached = evolve(current_matrix, rules)[[2]]

  while (border_reached == FALSE && iteration < max_iterations) {

    next_matrix = evolve(current_matrix, rules)[[1]]

    # Living border cells in the NEXT matrix?
    border_reached = evolve(current_matrix, rules)[[2]]
    if (border_reached == TRUE) {
      break
    } else {
      iteration = iteration + 1
      print(paste0("Time: ", iteration))
      draw_pixels(next_matrix)
      current_matrix = next_matrix
      Sys.sleep(1 / speed)
    }

  }
  # End while loop
  if (border_reached == TRUE) {
    print(paste0("Border was reached."))
  }
  if (iteration >= max_iterations) {
    print(paste0("Maximum number of iterations reached."))
  }
  return()  # placeholder for list which will contain values for GUI
}


# Testing ---------------------------------------------------------------------


# draw_pixels(simple_glider)
# automaton(simple_glider, "B3/S23", 1, 10)

# draw_pixels(big_glider)
# automaton(big_glider, "B3/S23", speed = 5, max_iterations = 100)

