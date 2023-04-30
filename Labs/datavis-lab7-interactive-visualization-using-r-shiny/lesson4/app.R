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
      selectInput(inputId='select_censusvis', label=strong("Choose a variable to display"), choices=list("Percent White" = 1, "Percent Black" = 2, "Percent Hispanic" = 3, "Percent Asian" = 4)),
      sliderInput(inputId='roi_censusvis', label=strong("Range of interest:"),  min=0, max=100, value=c(0, 100)),
      br(),
    ),
    mainPanel(
      textOutput(outputId="selected_var"),
      textOutput(outputId="selected_range")
    )
  )
)


server <- function(input, output) {
  output$selected_var <- renderText({
    paste("You have selected", input$select_censusvis)
  })
  
  output$selected_range <- renderText({
    paste("You have chosen a range that goes from", input$roi_censusvis[1], "to", input$roi_censusvis[2])
  })
}


shinyApp(ui = ui, server = server)