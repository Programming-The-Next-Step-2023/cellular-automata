#
#
# livelycells: Computations
#
#

# extract_rules() and count living neighbours() to evolve() a matrix



# extract_rules() --------------------------------------------------------------

#' BACKEND - extract_rules()
#'
#' This is a backend function.
#' DO NOT USE IT.
#' The only function in the livelycells package for a use is play()!
#'
#' Takes a string of rules in Golly/RLE format as input
#' and returns a list with two vectors.
#'
#' @param input_string The string in Folly/RLE format
#'
#' @return Returns a list of two elements. First element contains birth_rules.
#'  Second contains survival_rules.
#'
#' @export
extract_rules <- function(input_string) {

  separated_rules = unlist(strsplit(input_string, "/"))

  birth_rules = separated_rules[1]
  birth_rules = unlist(strsplit(birth_rules, ""))
  birth_rules = as.integer(birth_rules[-1])

  survival_rules = separated_rules[2]
  survival_rules = unlist(strsplit(survival_rules, ""))
  survival_rules = as.integer(survival_rules[-1])

  return(list(birth_rules, survival_rules))

}



# neighbours() -----------------------------------------------------------------

#' BACKEND - neighbours()
#'
#' This is a backend function.
#' DO NOT USE IT.
#' The only function in the livelycells package for a use is play()!
#'
#' Counts living neighbours in a cell´s Moore neighbourhood (the surrounding 8)
#'
#' @param matrix Matrix in question.
#'
#' @param row_index of the cell.
#'
#' @param colum_index of the cell.
#'
#' @return Returns a value between 0 and 8.
#'
#' @export
neighbours <- function(matrix, row_index, col_index) {

  living = 0

  # Use try() because of cells at borders who have < 8 neighbour cells
  # silent = TRUE because each matrix has border cells and will thus produce
  # errors

  try(
    if (matrix[row_index - 1, col_index - 1]) living = living + 1,  # North-West
    silent = TRUE
  )
  try(
    if (matrix[row_index - 1, col_index]) living = living + 1,  # North
    silent = TRUE
  )
  try(
    if (matrix[row_index - 1, col_index + 1]) living = living + 1,  # North-East
    silent = TRUE
  )

  try(
    if (matrix[row_index, col_index - 1]) living = living + 1,  # West
    silent = TRUE
  )
  try(
    if (matrix[row_index, col_index + 1]) living = living + 1,  # East
    silent = TRUE
  )

  try(
    if (matrix[row_index + 1, col_index - 1]) living = living + 1,  # South-West
    silent = TRUE
  )
  try(
    if (matrix[row_index + 1, col_index]) living = living + 1,  # South
    silent = TRUE
  )
  try(
    if (matrix[row_index + 1, col_index + 1]) living = living + 1,  # South-East
    silent = TRUE
  )

  return(living)
}



# evolve() ---------------------------------------------------------------------

#' BACKEND - evolve()
#'
#' This is a backend function.
#' DO NOT USE IT.
#' The only function in the livelycells package for a use is play()!
#'
#' Evolves a matrix to its next generation according to a rule set.
#'
#' @param input_matrix Matrix in question.
#'
#' @param rule_string in Golly/RLE format (e.g., "B3/S23")
#'
#' @return Returns a list of 2 elements. First is the matrix after
#'  evolution. Second is whether the border has been reached.
#'  If border_reached then input_matrix is simply returned.
#'
#' @export
evolve <- function(input_matrix, rule_string) {

  output_matrix = input_matrix
  number_of_rows = nrow(input_matrix)
  output_matrix[output_matrix == 1] <- 0

  rules = extract_rules(rule_string)

  border_reached = FALSE
  # Border cells alive? -> no change through evolution
  if (
    sum(input_matrix[1, ]) > 0 ||
    sum(input_matrix[nrow(input_matrix), ]) > 0 ||
    sum(input_matrix[, 1]) > 0 ||
    sum(input_matrix[, ncol(input_matrix)]) > 0
  ) {
    output_matrix = input_matrix
    border_reached = TRUE

  } else {  # Otherwise apply rule set

    # Which dead cells are born into life?
    list_dead = which(input_matrix == 0)
    for (i in list_dead) {

      # Indices of cell
      row_index = i %% number_of_rows
      if (row_index == 0) {
        row_index = number_of_rows
      }
      column_index = ceiling(i / number_of_rows)

      living_neighbours = neighbours(input_matrix, row_index, column_index)
      if (living_neighbours %in% rules[[1]]) {  # Birth rules met?
        output_matrix[i] = 1
      }
    }
    # End of birth computation

    # Which living cells survive?
    list_living = which(input_matrix == 1)
    for (i in list_living) {

      # Indices of cell
      row_index = i %% number_of_rows
      if (row_index == 0) {
        row_index = number_of_rows
      }
      column_index = ceiling(i / number_of_rows)

      living_neighbours = neighbours(input_matrix, row_index, column_index)
      if (living_neighbours %in% rules[[2]]) {  # Survival rules met?
        output_matrix[i] = 1
      }

    }  # End survival computation

  }  # End computation output_matrix

  return(list(output_matrix, border_reached))
}
