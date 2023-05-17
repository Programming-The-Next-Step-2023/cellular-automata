library("livelycells")


test_that("neighbours() returns correct number of living neighbour cells", {

  # Load border cells
  folder_path = paste0(testthat::test_path(), "/testdata/border_cells")
  border_cells = as.list(dir(path = folder_path))
  for (i in 1:length(border_cells)) {
    file_path = paste0(folder_path, "/", border_cells[i])
    load(file_path)
  }

  expect_equal(neighbours(border_north_east, 1, 1), 1)
  expect_equal(neighbours(border_north, 1, 5), 5)
  expect_equal(neighbours(border_north_west, 1, 2), 1)
  expect_equal(neighbours(border_west, 8, 1), 2)
  expect_equal(neighbours(border_east, 8, 8), 2)
  expect_equal(neighbours(border_south_west, 7, 8), 3)
  expect_equal(neighbours(border_south, 3, 2), 1)
  expect_equal(neighbours(border_south_east, 5, 1), 1)

})


test_that("extract_rules() yield a birth vector and survival vector", {

  rules = extract_rules("B3/S012345678")
  birth_rules = rules[[1]]
  survival_rules = rules[[2]]

  expect_equal(birth_rules, c(3))
  expect_equal(survival_rules, c(0, 1, 2, 3, 4, 5, 6, 7, 8))

})


test_that("evolve() does not evolve border cases and still lifes", {

  # Border case
  mat1 = matrix(c(0, 1), nrow = 4, ncol = 4)
  next_mat1 = evolve(mat1, "B3/S23")[[1]]
  border_reached = evolve(mat1, "B3/S23")[[2]]
  expect_equal(mat1, next_mat1)
  expect_true(border_reached == TRUE)

  # Still life: Block
  mat2 = matrix(c(rep(0, 4), c(0, 1, 1, 0), c(0, 1, 1, 0), c(rep(0, 4))),
                  ncol = 4)
  next_mat2 = evolve(mat2, "B3/S23")[[1]]
  border_reached = evolve(mat2, "B3/S23")[[2]]
  expect_equal(mat2, next_mat2)
  expect_true(border_reached == FALSE)

})
