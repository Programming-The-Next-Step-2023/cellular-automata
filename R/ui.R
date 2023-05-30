#
#
# Shiny Life-Like Cells: UI
#
#


#' @import shiny


# UI ---------------------------------------------------------------------------

ui <- fluidPage(
  title = "Lively Cells 🔬 - An R Shiny App",

  # TitlePanel ----
  titlePanel(
    h1("Lively Cells 🔬"),
  ),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Intro Text ---
      h4("What is this?"),
      p("This is an R Shiny App for ",
        a("Conway´s Game of Life",
          target = "_blank",  # opens in new tab
          href = "https://en.wikipedia.org/wiki/Conway's_Game_of_Life"
        ),
        "built by ",
        a("Vincent Ott",
          target = "_blank",
          href = "https://github.com/vincentott"
        ),
        "with the help of ",
        a("work",
          target = "_blank",
          href = "https://www.rostrum.blog/2022/09/24/pixeltrix/"
        ),
        "by ",
        a("Matt Dray",
          target = "_blank",
          href = "https://www.matt-dray.com/"
        ),
        "."
      ),  # End intro text

      p("Conway´s Game of Life simulates cells on a grid which can
        either be dead or alive. The cells evolve over time based on two rules:\n",
        "A live cell with two or three live neighbours survives - otherwise it dies.
        A dead cell with three live neighbours becomes a live cell.",
        "This leads to interesting and often unpredictable behavior."
      ),

      # Header ---
      h4("How to play"),
      p("Click into the grid to bring some cells to life. ",
        "Clicking on a live cell kills it. ",
        "Try to stay in the middle of the grid as the simulation cannot
        continue beyond its border.",
        "Wake up the cells to start the simulation.",
        "Keep an eye on the status info below the grid. ",
        "Once the cells are awake, lively, and plenty, it may take
        a while to 🌒, ⚰️, or load a pattern."
        ),
      br(),

      # Controls ----
      h4("Controls"),
      actionButton("start_button", "Wake Up ☀️"),
      actionButton("stop_button", "Sleep 🌒"),
      actionButton("kill_button", "Kill all ⚰️"),
      br(),

      # Load Pattern ---
      h5("Load a pattern:"),
      actionButton("butterfly_button", "🦋"),
      actionButton("galaxy_button", "🌀"),
      actionButton("gun_button", "🔫"),
      actionButton("diehard_button", "⌛"),
      actionButton("spaceship_button", "🚀"),
      actionButton("random_button", "🎲"),


    width = 3  # Relative to mainPanel
    ),  # End sidePanel

    # Main panel for displaying outputs ----
    mainPanel(

      # Plot ----
      plotOutput("shown_plot", height = 600, width = 1025, click = "plot_click"),

      # User Info ----
      textOutput("user_info"),
      textOutput("current_generation"),
      textOutput("current_population"),

    )  # End mainPanel

  )  # End sidebarLayout

)  # End UI
