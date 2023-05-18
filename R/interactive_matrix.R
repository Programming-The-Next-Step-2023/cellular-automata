#
#
#
# Shiny Life-Like Cells: interactive_matrix
#
# draws a clickable matrix

# Source------------------------------------------------------------------------
# Load test_matrices
test_matrices = as.list(dir(path = "./data/test_matrices"))
for (i in 1:length(test_matrices)) {
  file_path = paste0("./data/test_matrices/", test_matrices[i])
  load(file_path)
}


# vizMat() ---------------------------------------------------------------------
# Adapted via ChatGPT from:
# stackoverflow.com/questions/68669634/how-do-i-graph-a-matrix-using-ggplot

library(tidyverse)
vizMat <- function(input_matrix) {

  input_matrix <- input_matrix[nrow(input_matrix):1,]

  # Store dimensions for labeling
  no_rows <- dim(input_matrix)[1]
  no_cols <- dim(input_matrix)[2]

  # Create labels
  row_id_df <- paste0("row", sprintf("%02d", 1:no_rows))
  col_id_df <- paste0("col", sprintf("%02d", 1:no_cols))

  # Transpose and create dataframe
  df <- as.data.frame(t(input_matrix))
  # Assign labels
  names(df) <- row_id_df

  # Pivot Shenanigans
  df <- df %>% mutate(col_id = col_id_df)
  df <- df %>% select(col_id, everything())
  df <- df %>% pivot_longer(-col_id)

  # Plot
  df %>%
    ggplot(aes(x = col_id, y = name, fill = value)) +
    geom_tile(color = "black", size = 0.3, show.legend = FALSE) +
    scale_fill_gradient(low = "white", high = "green") +
    theme_minimal() +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank())

}


vizMat(simple_glider)



