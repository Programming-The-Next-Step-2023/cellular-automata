# #
# #
# # Shiny Life-Like Cells: Automaton
# #
# # all the vitals for an Automaton
#
#

# # Load test_matrices
# test_matrices = as.list(dir(path = "./data/test_matrices"))
# for (i in 1:length(test_matrices)) {
#   file_path = paste0("./data/test_matrices/", test_matrices[i])
#   load(file_path)
# }
#
#
# # automaton() --------------------------------------------------------------
#
# automaton <- function(input_matrix, rules, speed, max_iterations) {
#
#   iteration = 0
#   current_matrix = input_matrix
#
#   # Living border cells in the INITIAL matrix?
#   border_reached = evolve(current_matrix, rules)[[2]]
#
#   while (border_reached == FALSE && iteration < max_iterations) {
#
#     next_matrix = evolve(current_matrix, rules)[[1]]
#
#     # Living border cells in the NEXT matrix?
#     border_reached = evolve(current_matrix, rules)[[2]]
#     if (border_reached == TRUE) {
#       break
#     } else {
#       iteration = iteration + 1
#       print(paste0("Time: ", iteration))
#       draw_pixels(next_matrix)
#       current_matrix = next_matrix
#       Sys.sleep(1 / speed)
#     }
#
#   }
#   # End while loop
#   if (border_reached == TRUE) {
#     print(paste0("Border was reached."))
#   }
#   if (iteration >= max_iterations) {
#     # print(paste0("Maximum number of iterations reached."))
#   }
#   return()  # placeholder for list which will contain values for GUI
# }
#
#
# # draw_pixels(verti_line_gen0)
# # automaton(verti_line_gen0, "B3/S23", 1, 1)
# #
# # draw_pixels(hori_line_gen0)
# # automaton(hori_line_gen0, "B3/S23", 1, 1)
#
# # draw_pixels(glider)
#
# # draw_pixels(big_glider)
# # automaton(big_glider, "B3/S23", speed = 1, max_iterations = 100)
#
#
# # draw_pixels(toad)
# # automaton(toad, "B3/S23", max_iterations = 15, speed = 5)  # Life
# # draw_pixels(beehive)
# # automaton(beehive, "B3/S23", max_iterations = 7, speed = 5)
