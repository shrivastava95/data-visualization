# Lesson 2
# Build a user interface - building the first app from scratch
# 1. Building a user interface
# 2. Layout of the user interface
# 3. Add text, images, and other HTML elements to your Shiny app.

library(shiny)


ui <- fluidPage(
  titlePanel(strong("My Shiny App")),
  
  sidebarLayout(
    sidebarPanel(
      h2("Installation"),
      p("Shiny is available on CRAN, so you can install it in the usual way from your R console:"),
      code('install.packages("shiny")'),
      br(),br(),
      
      img(src= "rstudio.png", height=70, width=200),
      "Shiny is a product of ", 
      span("RStudio", style = "color:blue")
    ),
    mainPanel(
      h1(strong("Introducing Shiny")),
      p("Shiny is a new package from RStudio that makes it ", em("incredibly easy"), " to build interactive web applications with R."),
      br(),
      p("For an introduction and live examples, visit the ", a("Shiny homepage.", href="http://shiny.rstudio.com")),
      br(),
      h2("Features"),
      p("- Build useful web applications with only a few lines of code-no Javascript required."),
      p("- Shiny applications are automatically 'live' in the same way that ", strong("spreadsheets"), " are live. Outputs change instantly as users modify inputs, without requiring a reload of the browser.")
    )
  )
)


server <- function(input, output) {
  
}


shinyApp(ui = ui, server = server)