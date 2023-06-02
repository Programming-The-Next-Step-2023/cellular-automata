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


test_that("extract_rules() yields usable birth and survival list", {

  rules = extract_rules("B3/S23")
  birth_rules = rules[[1]]
  survival_rules = rules[[2]]

  expect_false(0 %in% birth_rules)
  expect_false(2 %in% birth_rules)
  expect_true(3 %in% birth_rules)
  expect_false(8 %in% birth_rules)

  expect_true(2 %in% survival_rules)
  expect_true(3 %in% survival_rules)
  expect_false(4 %in% survival_rules)

})


test_that("evolve() does not evolve border cases and still lifes", {

  # Border case
  mat1 = matrix(c(0, 1), nrow = 4, ncol = 4)
  next_mat1 = evolve(mat1, "B3/S23")[[1]]
  border_reached = evolve(mat1, "B3/S23")[[2]]
  expect_equal(mat1, next_mat1)
  expect_true(border_reached)

  # Still life: Block
  mat2 = matrix(c(rep(0, 4), c(0, 1, 1, 0), c(0, 1, 1, 0), c(rep(0, 4))),
                ncol = 4)
  next_mat2 = evolve(mat2, "B3/S23")[[1]]
  border_reached = evolve(mat2, "B3/S23")[[2]]
  expect_equal(mat2, next_mat2)
  expect_false(border_reached)


  # Load
  folder_path = paste0(testthat::test_path(), "/testdata/evolve_checks")
  evolve_checks = as.list(dir(path = folder_path))
  for (i in 1:length(evolve_checks)) {
    file_path = paste0(folder_path, "/", evolve_checks[i])
    load(file_path)
  }

  # Still life + Glider approaching border
  testthat::expect_equal(evolve(evo1_gen0, "B3/S23")[[1]], evo1_gen1)
  testthat::expect_equal(evolve(evo1_gen0, "B3/S23")[[2]], FALSE)

  testthat::expect_equal(evolve(evo1_gen1, "B3/S23")[[1]], evo1_gen1)
  testthat::expect_equal(evolve(evo1_gen1, "B3/S23")[[2]], TRUE)

  # Border lines
  testthat::expect_equal(evolve(verti_line_gen0, "B3/S23")[[1]], verti_line_gen1)
  testthat::expect_equal(evolve(hori_line_gen0, "B3/S23")[[1]], hori_line_gen1)

})




