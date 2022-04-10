## -----------------------------------------------------------------------------
##
## Purpose of script: Helper functions
##
## Author: Ashirwad Barnwal
##
## Date Created: 2022-04-10
##
## Copyright (c) Ashirwad Barnwal, 2022
## Email: ashirwad@iastate.edu; ashirwad1992@gmail.com
##
## -----------------------------------------------------------------------------
##
## Notes: This script contains helper functions to help simplify data
## manipulation & visualization operations.
##
## -----------------------------------------------------------------------------


# Fix html dependency for leaflet maps created with mapview --------------------
fix_html_dependency <- function(map_view) {
  # Get the path of leaflet providers
  leaf_providers_path <- fs::dir_ls(
    renv::paths$cache(),
    type = "directory",
    glob = "*leaflet.providers*leaflet.providers",
    recurse = TRUE
  ) %>%
    as.character()

  # Fix the dependency path for leaflet providers
  dependency_names <- map_view@map$dependencies %>%
    purrr::map(~ purrr::pluck(.x, "name")) %>%
    purrr::as_vector()

  map_view@map$dependencies <- map_view@map$dependencies %>%
    purrr::set_names(dependency_names) %>%
    purrr::assign_in(
      list("leaflet-providers", "src", "file"), leaf_providers_path
    )
  map_view
}
