#
#
#
# Shiny Life-Like Cells: interactive_matrix
#
# draws a clickable matrix


# Tests ------------------------------------------------------------------------

# # Standard Method
# mat1 = diag(5)
# print(mat1)
# t_mat1 = t(mat1[nrow(mat1):1, ])
# image(t_mat1, axes = FALSE)
#
# # Standard: Non-quadratic
# mat2 = matrix(c(1, 0, 1), nrow = 3, ncol = 2)
# t_mat2 = t(mat2[nrow(mat2):1, ])
# image(t_mat2, axes = FALSE)


# ggplot: Overflow:
# stackoverflow.com/questions/68669634/how-do-i-graph-a-matrix-using-ggplot
# library(tidyverse)
#
# vizMat <- function(thisMAT) {
#   n_max <- dim(thisMAT)[1]
#   column_names_for_df <- paste0("V", sprintf("%02d",1:n_max))
#   df <- rev(as.data.frame(t(thisMAT)))
#   names(df) <- VNN
#   df %>%
#     mutate(row_num = VNN) %>%
#     select(row_num, everything()) %>%
#     pivot_longer(-row_num) %>%
#     ggplot(aes(x=row_num, y=name, fill=value)) +
#     geom_raster(show.legend = F) +
#     # scale_fill_gradient2(low = "red",
#     #                      mid = "white",
#     #                      high = "navy", midpoint = .02) +
#     # theme_void()
# }
#
# MAT <-  matrix(c(100, 7, 0, 0, 49, 0, 0, 0, -49), nrow = 3, ncol = 3)
# vizMat(MAT)





# library(tidyverse)
#
# mat3 = diag(3)
# dim(mat3)
# df <- as.data.frame(mat3)
# df <- df %>% mutate(row = row_number())
# print(df)
# rownames(df)
# colnames(df)
#
# df %>% pivot_longer(cols = "row",
#                     names_to = colnames(),
#                     values_to = "cell_values"
# )
#
# %>%
#   ggplot(aes(x=as.numeric(contacts), y=as.numeric(Day), fill=counts)) +
#   geom_tile() +
#   scale_fill_viridis_c()




