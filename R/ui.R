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
          target = "_blank",  # opens in new tab
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
        "These rules create interesting and often unpredictable behaviors."
      ),
      br(),

      # Header ---
      h4("How to play"),

      # Use Mouse ---
      p("Click into the grid on the right ",
        "to bring some cells to life.",
        "Clicking on a living cell kills it.️"
      ),

      br(),
      p("Next, select ",
        a("Rule Set",
          target = "_blank",  # opens in new tab
          href = "https://en.wikipedia.org/wiki/Life-like_cellular_automaton#A_selection_of_Life-like_rules"
          ),
        "& Evolution Speed:"
      ),

      # # Input: Selector for rules ----
      # selectInput(
      #   inputId = "rules",
      #   label = "Rule Set",
      #   choices = c("Life - B3/S23",
      #               "Life without Death - B3/S012345678",
      #               "Seeds - B2/S",
      #               "Replicator - B1357/S1357")
      # ),

      # # Speed ---
      # selectInput(
      #   inputId = "evolution_speed",
      #   label = "Evolution Speed (Generations per Second)",
      #   choices = c("1300",
      #               "1000",
      #               "750")
      # ),

      # Controls ----
      h4("Controls"),
      actionButton("start_button", "Wake Up ☀️"),
      actionButton("stop_button", "Sleep 🌒"),
      actionButton("kill_button", "Kill all ⚰️"),
      br(),

      # Load Pattern ---
      br(),
      # selectInput(
      #   inputId = "pattern",
      #   label = "Preconfigured Patterns:",
      #   choices = c("Oscillators",
      #               "Space Ships",
      #               "Glider Gun",
      #               "Random Noise")
      # ),
      h5("Load in Pre-Configured Patterns"),
      actionButton("osci_button", "️Oscillators"),
      actionButton("ships_button", "️Space Ships"),
      br(),
      br(),
      actionButton("gun_button", "Glider Gun"),
      actionButton("noise_button", "Random"),

    width = 3  # Relative to mainPanel
    ),  # End sidePanel

    # Main panel for displaying outputs ----
    mainPanel(

      # Plot ----
      plotOutput("shown_plot", height = 600, width = 1025, click = "plot_click"),

      # User Info ----
      textOutput("user_info"),
      # textOutput("coder_info"),
      textOutput("current_generation"),
      textOutput("current_population"),

      # verbatimTextOutput("click_info"),

    )  # End mainPanel

  )  # End sidebarLayout

)  # End UI
