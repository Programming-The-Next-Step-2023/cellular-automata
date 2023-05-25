# Understanding pixeltrix -------------------

# function receives a matrix and a x y coordinates as input
# Adapted from pixeltrix
click_to_cell <- function(input_matrix, input_x, input_y) {

  # Pixel centres, x axis
  x_n    <- ncol(input_matrix)    # number of pixels in the x dimension
  x_unit <- 1 / (x_n - 1)         # x width of pixels
  x_mids <- seq(0, 1, x_unit)     # full set of pixel centres on x axes

  # Pixel centres, y axis
  y_n    <- nrow(input_matrix)
  y_unit <- 1 / (y_n - 1)
  y_mids <- seq(0, 1, y_unit)

  # Calculate distances xy from clicked point to pixel centres
  x_diffs <- abs(input_x - x_mids)
  y_diffs <- rev(abs(input_y - y_mids))

  output_coords <- list(
    x <- which.min(y_diffs),
    y <- which.min(x_diffs)
  )

  return(output_coords)
}


#
# load("./data/test_matrices/glider.Rdata")
# draw_pixels(glider)
# coordinates = locator()
# coordinates$x
# coordinates$y
#
# row_index = click_to_cell(glider, coordinates$x, coordinates$y)[[1]]
# col_index = click_to_cell(glider, coordinates$x, coordinates$y)[[2]]
#
# # Update value in matrix cell
# if (glider[point$y, point$x] == 0) {
#   glider[point$y, point$x] <- 1
# } else {
#   glider[point$y, point$x] <- 0
# }
#
# draw_pixels(glider)

