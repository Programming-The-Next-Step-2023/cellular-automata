#
#
# Shiny Life-Like Cells: UI
#
# sourced and used in app.R



# Source -----------------------------------------------------------------------



# UI ---------------------------------------------------------------------------

ui <- shiny::fluidPage(

  title = "Lively Cells / Vincent Ott",

  # TitlePanel ----
  shiny::titlePanel(
    shiny::h1("Lively Cells", style = "color:black")
  ),


  # Sidebar layout with input and output definitions ----
  shiny::sidebarLayout(

    # Sidebar panel for inputs ----
    shiny::sidebarPanel(

      # Intro Text ---
      shiny::h4("What is this?"),
      shiny::p("This is an intro text to cellular automata.
        Lorem ipsum dolor sit amet oder so. Hahahahahahahahaha!"),
      shiny::hr(),

      # Header ---
      shiny::h4("How to play"),

      shiny::p("Select a Rule Set",
        "(see ",
        shiny::a("Wikipedia",
          target = "_blank",  # opens in new tab
          href = "https://en.wikipedia.org/wiki/Life-like_cellular_automaton#A_selection_of_Life-like_rules"
          ),
        "):"),

      # Input: Selector for rules ----
      shiny::selectInput(
        inputId = "rules",
        label = "Rule Set",
        choices = c("Life - B3/S23",
                    "Life without Death - B3/S012345678",
                    "Seeds - B2/S",
                    "Replicator - B1357/S1357")
      ),

      # Use Mouse ---
      shiny::p("Then,",
               shiny::br(),
               "click into the grid on the right ",
               "to bring some cells to life.",
               "Clicking on a living cell kills it."),
      shiny::br(),

      # Controls ---
      shiny::h4("Controls"),
      shiny::actionButton("start_button", "Start"),
      shiny::actionButton("stop_button", "Stop"),
      shiny::br(),
      shiny::br(),
      shiny::numericInput("evolution_speed", "Evolution Speed (Generations per Second)",
                   value = 5, min = 0, max = 10000),
      shiny::numericInput("max_generations", "Maximum Number of Generations",
                   value = 250, min = 1, max = 1000000),
      shiny::br(),
      shiny::actionButton("gen0_button", "Reinstate Generation 0"),
      shiny::actionButton("kill_button", "Kill All Cells"),

    width = 3  # Relative to mainPanel
    ),

    # Main panel for displaying outputs ----
    shiny::mainPanel(

      # Submitted Automaton Arguments ----
      shiny::textOutput("submitted_arguments"),

      # Reactive Automaton Arguments ----
      shiny::textOutput("selected_rules"),
      shiny::textOutput("evolution_speed"),
      shiny::textOutput("max_generations")

    )

  )

) # end UI
