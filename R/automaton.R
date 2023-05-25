#
#
# Shiny Life-Like Cells: Automaton
#
# all the vitals for an Automaton



# Source -----------------------------------------------------------------------

source("./R/computations.R")
source("./R/pixeltrix.R")


# Load test_matrices
test_matrices = as.list(dir(path = "./data/test_matrices"))
for (i in 1:length(test_matrices)) {
  file_path = paste0("./data/test_matrices/", test_matrices[i])
  load(file_path)
}

# automaton() ------------------------------------------------------------------

automaton <- function(input_matrix, rules, speed) {

  iteration = 0
  current_matrix = input_matrix

  while(iteration < 100) {
    iteration = iteration + 1
    print(paste0("Time: ", iteration))
    next_matrix = evolve(current_matrix, rules)
    draw_pixels(next_matrix)
    current_matrix = next_matrix
    Sys.sleep(1 / speed)
  }

}




# automaton_old() --------------------------------------------------------------

automaton_old <- function(input_matrix, rules, speed, max_iterations) {

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
    # print(paste0("Maximum number of iterations reached."))
  }
  return()  # placeholder for list which will contain values for GUI
}


# draw_pixels(verti_line_gen0)
# automaton_old(verti_line_gen0, "B3/S23", 1, 1)
#
# draw_pixels(hori_line_gen0)
# automaton_old(hori_line_gen0, "B3/S23", 1, 1)

# draw_pixels(glider)
# draw_pixels(evolve(glider, "B3/S012345678"))
# automaton(glider, "B2/", 1)

# border_test = click_pixels(5, 5)
# automaton(border_test, "B3/S23", 0.5)



# big_glider = click_pixels(60, 103)
# draw_pixels(big_glider)
# automaton(big_glider, "B3/S23", speed = 1, max_iterations = 100)
# setwd(paste0(getwd(), "/data/test_matrices"))  # Point to folder with data
# save(big_glider, file = "big_glider.Rdata")



# draw_pixels(toad)
# automaton(toad, "B3/S23", max_iterations = 15, speed = 5)  # Life
# automaton(toad, "B2/S", max_iterations = 50, speed = 5)  # Seeds
# automaton(toad, "B2/S", max_iterations = 3, speed = 5)  # Seeds
#
# draw_pixels(beehive)
# automaton(beehive, "B3/S23", max_iterations = 7, speed = 5)


# misc_cells = click_pixels(50, 86)
# save(misc_cells, file = "misc_cells.Rdata")

# glider50 = click_pixels(50, 86)
# save(glider50, file = "glider50.Rdata")
