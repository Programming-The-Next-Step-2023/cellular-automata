#
#
# Shiny Life-Like Cells: UI
#
# Sourced and used in app.R



# Source -----------------------------------------------------------------------



# UI ---------------------------------------------------------------------------

ui <- shiny::fluidPage(
  title = "Lively Cells / Vincent Ott",

  # TitlePanel ----
  shiny::titlePanel(
    shiny::h1("Lively Cells 🔬"),

    # credits ---
    shiny::p("built by Vincent Ott with the help of ",
      shiny::a("work",
      target = "_blank",  # opens in new tab
      href = "https://www.rostrum.blog/2022/09/24/pixeltrix/"
    ),
      "by",
      shiny::a("Matt Dray",
        target = "_blank",  # opens in new tab
        href = "https://www.matt-dray.com/"
      ),
    )
  ),


  # Sidebar layout with input and output definitions ----
  shiny::sidebarLayout(

    # Sidebar panel for inputs ----
    shiny::sidebarPanel(

      # Intro Text ---
      shiny::h4("What is this?"),
      shiny::p("This is an intro text to cellular automata.
        Lorem ipsum dolor sit amet oder so. Hahahahahahahahaha!"),
      shiny::br(),

      # Header ---
      shiny::h4("How to play"),

      # Use Mouse ---
      shiny::p("Click into the grid on the right ",
               "to bring some cells to life.",
               "Clicking on a living cell kills it.️"),

      shiny::br(),
      shiny::p("Next, select ",
        shiny::a("Rule Set",
          target = "_blank",  # opens in new tab
          href = "https://en.wikipedia.org/wiki/Life-like_cellular_automaton#A_selection_of_Life-like_rules"
          ),
        "& Evolution Speed:"
      ),

      # Input: Selector for rules ----
      shiny::selectInput(
        inputId = "rules",
        label = "Rule Set",
        choices = c("Life - B3/S23",
                    "Life without Death - B3/S012345678",
                    "Seeds - B2/S",
                    "Replicator - B1357/S1357")
      ),

      # Speed ---
      shiny::selectInput(
        inputId = "evolution_speed",
        label = "Evolution Speed (Generations per Second)",
        choices = c("1300",
                    "1000",
                    "750")
      ),

      # Controls ----
      shiny::h4("Controls"),
      shiny::actionButton("start_button", "Wake Up ☀️"),
      shiny::actionButton("stop_button", "Sleep 🌒"),
      shiny::actionButton("kill_button", "Kill all ⚰️"),
      shiny::br(),

      # Load Pattern ---
      shiny::br(),
      shiny::selectInput(
        inputId = "pattern",
        label = "Preconfigured Patterns:",
        choices = c("Oscillators",
                    "Space Ships",
                    "Glider Gun",
                    "Random Noise")
      ),
      shiny::actionButton("load_button", "Send pattern to petri dish ↗️"),

    width = 3  # Relative to mainPanel
    ),

    # Main panel for displaying outputs ----
    shiny::mainPanel(

      # Plot ----
      shiny::plotOutput("shown_plot", height = 600, width = 1025,
                        click = "plot_click"
      ),

      # User Info ----
      shiny::textOutput("user_info"),
      shiny::textOutput("coder_info"),
      shiny::textOutput("current_generation"),
      shiny::textOutput("current_population"),

      shiny::verbatimTextOutput("click_info"),

      # # Submitted Automaton Arguments ----
      # shiny::textOutput("submitted_arguments"),
      #
      # # Reactive Automaton Arguments ----
      # shiny::textOutput("selected_rules"),
      # shiny::textOutput("evolution_speed"),
      # shiny::textOutput("max_generations")

    )

  )

) # end UI
