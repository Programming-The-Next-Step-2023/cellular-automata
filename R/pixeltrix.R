# Stolen with eternal thankfulness and adapted from:
# https://github.com/matt-dray/pixeltrix
# Date of retrieval: 2023-05-19

# helper functions ----
# Plot 'pixels' given the dimensions of the input matrix
plot_canvas <- function(m, n_states, colours) {

  par_start <- graphics::par(mar = rep(0, 4))  # set margins, save current

  n_rows <- nrow(m)
  n_cols <- ncol(m)

  if (n_rows > 1 & n_cols > 1) {
    m <- t(m[seq(n_rows, 1), ])
  }

  # Transpose/reverse needed with pixel dimension of 1
  if (n_rows == 1) m <- t(m)
  if (n_cols == 1) m <- t(rev(m))

  graphics::image(
    m,
    zlim = c(0, n_states - 1),
    col  = colours,
    axes = FALSE,
    xlab = "",
    ylab = ""
  )

  on.exit(graphics::par(par_start))  # revert to user's original settings

}

# Get XY location of plotted 'pixel' that's been clicked by the user
locate_on_grid <- function(m) {

  # Pixel centres, x axis
  x_n    <- ncol(m)            # number of pixels in the x dimension
  x_unit <- 1 / (x_n - 1)      # x width of pixels
  x_mids <- seq(0, 1, x_unit)  # full set of pixel centres on x axes

  # Pixel centres, y axis
  y_n    <- nrow(m)
  y_unit <- 1 / (y_n - 1)
  y_mids <- seq(0, 1, y_unit)

  point <- graphics::locator(1)  # prompt for interactive click

  if (length(point) == 0) {  # if early escape from locator()
    return(NULL)
  }

  # Calculate distances xy from clicked point to pixel centres
  x_diffs <- abs(point$x - x_mids)
  y_diffs <- rev(abs(point$y - y_mids))

  # Identify pixel closest to click
  point <- list(
    x = which.min(x_diffs),
    y = which.min(y_diffs)
  )

  # Default to 1 if there's no point
  if (length(point$x) == 0) point$x <- 1
  if (length(point$y) == 0) point$y <- 1

  return(point)

}

# Increment the value of the matrix that corresponds to the clicked 'pixel'
update_matrix <- function(m, point, n_states) {

  states        <- seq(0L, n_states - 1L)  # available pixel states (0, 1, ...)
  current_state <- m[point$y, point$x]     # current state of pixel (e.g. 0)
  next_state    <- current_state + 1L      # next consecutive state (e.g. 1)

  if (next_state > n_states - 1L) {
    next_state <- states[1]  # wrap from last to first state (e.g. 0, 1, 0)
  }

  m[point$y, point$x] <- next_state  # update the state for that pixel

  m

}


# Loop continuously to accept a click, update matrix values, then re-plot
repeat_loop <- function(m, n_states, colours, grid) {

  message("Click squares in the plot window. Press <Esc> to end.")

  repeat {

    point <- locate_on_grid(m)

    if (is.null(point)) break

    m <- update_matrix(m, point, n_states)

    grDevices::dev.off()

    plot_canvas(m, n_states, colours)
    if (grid) add_grid(m)

  }

  m

}



# Draw a grid over the plotted matrix to differentiate 'pixels'
add_grid <- function(m) {

  x_n <- ncol(m)

  if (x_n == 1) {
    x_lines <- c(-1, 1)  # boundaries are -1,1 if only one pixel on this axis
  }

  if (x_n > 1) {

    x_unit  <- 1 / (x_n - 1)  # width of one pixel

    x_lines <- seq(  # min/max pixel centres at -1,1, but there's 'overhang'
      0 - x_unit - (x_unit / 2),  # add half a pixel overhang at min
      1 + x_unit + (x_unit / 2),  # add half a pixel overhang at max
      x_unit
    )

  }

  y_n <- nrow(m)

  if (y_n == 1) {
    y_lines <- c(-1, 1)
  }

  if (y_n > 1) {

    y_unit  <- 1 / (y_n - 1)

    y_lines <- seq(
      0 - y_unit - (y_unit / 2),
      1 + y_unit + (y_unit / 2),
      y_unit
    )

  }

  # Draw gridlines to plot
  graphics::abline(v = x_lines)
  graphics::abline(h = y_lines)

}





# click_pixels() ----
click_pixels <- function(
    n_rows   = 8L,
    n_cols   = 8L,
    n_states = 2L,
    colours  = c("white", "green"),
    grid     = TRUE
) {

  # Initiate matrix, draw, let user interact
  m <- matrix(0L, n_rows, n_cols)
  plot_canvas(m, n_states, colours)
  if (grid) add_grid(m)
  m <- repeat_loop(m, n_states, colours, grid)

  # Add colours as an attribute to returned matrix
  attr(m, "colours") <- stats::setNames(colours, seq(0, n_states - 1))

  m

}



# draw_pixels() ----
draw_pixels <- function(m, colours = NULL) {

  # Retrieve n_states from attributes or matrix values
  if (!is.null(attr(m, "colours"))) {
    n_states <- length(attr(m, "colours"))
  } else if (is.null(attr(m, "colours"))) {
    n_states <- max(unique(as.vector(m))) + 1L
  }

  # Take colours from attributes of input matrix, if present
  if (is.null(colours) & !is.null(attr(m, "colours"))) {
    colours <- attr(m, "colours")
  }

  # If matrix has no 'colours' attribute, create gradated grey palette
  if (is.null(colours) & is.null(attr(m, "colours"))) {
    get_greys <- grDevices::colorRampPalette(c("white", "grey20"))
    colours   <- get_greys(n_states)  # gradated colours from white to dark grey
  }



  par_start <- graphics::par(mar = rep(0, 4))  # set margins, store previous par

  graphics::image(
    t(m[nrow(m):1, ]),  # reverse matrix rows and transpose
    col = colours,
    axes = FALSE,
    xlab = "",
    ylab = ""
  )

  add_grid(m)

  on.exit(graphics::par(par_start))  # revert to user's original settings

}


# Create some test matrices for computations -----------------------------------
# they are used in computations.R

#setwd(paste0(getwd(), "/data/test_matrices"))  # Point to folder with data

#border_north_east = click_pixels(7, 7)
#save(border_north_east, file = "border_north_east.Rdata")

#border_north = click_pixels(6, 6)
#save(border_north, file = "border_north.Rdata")

#border_north_west = click_pixels(2, 2)
#save(border_north_west, file = "border_north_west.Rdata")

#border_west = click_pixels(13, 22)
#save(border_west, file = "border_west.Rdata")

#border_east = click_pixels(19, 8)
#save(border_east, file = "border_east.Rdata")

#border_south_east = click_pixels(5, 5)
#save(border_south_east, file = "border_south_east.Rdata")

#border_south = click_pixels(3, 3)
#save(border_south, file = "border_south.Rdata")

#border_south_west = click_pixels(7, 8)
#save(border_south_west, file = "border_south_west.Rdata")

#beehive = click_pixels(15, 15)
#save(beehive, file = "beehive.Rdata")

#toad = click_pixels(15, 15)
#save(toad, file = "toad.Rdata")

#simple_glider = click_pixels(6, 6)
#save(simple_glider, file = "simple_glider.Rdata")

#glider = click_pixels(15, 15)
#save(glider, file = "glider.Rdata")
