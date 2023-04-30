# Lesson 2
# Build a user interface - building the first app from scratch
# 1. Building a user interface
# 2. Layout of the user interface
# 3. Add text, images, and other HTML elements to your Shiny app.

library(shiny)


ui <- fluidPage(
  titlePanel(strong("censusVis")),
  
  sidebarLayout(
    sidebarPanel(
      p("Create demographic maps with information from the 2010 US Census."),
      selectInput(inputId='select-censusvis', label=strong("Choose a variable to display"), choices=list("Percent White" = 1, "Percent Black" = 2, "Percent Hispanic" = 3, "Percent Asian" = 4)),
      sliderInput(inputId='roi-censusvis', label=strong("Range of interest:"),  min=0, max=100, value=c(0, 100)),
      br(),
    ),
    mainPanel()
  )
)


server <- function(input, output) {
  
}


shinyApp(ui = ui, server = server)