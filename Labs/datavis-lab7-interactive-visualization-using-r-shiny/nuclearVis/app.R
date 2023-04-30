library(shiny)
library(leaflet)
library(dplyr)


landmarks <- read.csv("data/nuclear_explosions.csv")

ui <- fluidPage(
  titlePanel(p(h1(strong("nuclearVis")), "\nMade in R Shiny by Ishaan Shrivastava")),
  
  
  sidebarLayout(
    
    sidebarPanel(
      p("This is an app made to show every single nuclear explosion that took place in the history of humanity, since the first one in 1945, all the way uptil 1998."),
      sliderInput("year_range", label = "Select Year Range",
                  min = min(landmarks$year), max = max(landmarks$year),
                  value = c(min(landmarks$year), max(landmarks$year))),
    ),
    mainPanel(
      strong(h1((textOutput("num_explosions")))),
      leafletOutput("map"),
    )
  )
  # Create the text output for the number of explosions
  
)

server <- function(input, output) {
  
  filtered_data <- reactive({
    landmarks %>%
      filter(year >= input$year_range[1] & year <= input$year_range[2])
  })
  
  num_explosions <- reactive({
    nrow(filtered_data())
  })
  
  output$map <- renderLeaflet({
    
    # Define the color palette based on the yield_upper column
    yield_range <- log10(filtered_data()$yield_upper + 1)
    color_pal <- colorNumeric(
      palette = c("#FFEDA0", "#FEB24C", "#FC4E2A", "#BD0026"), 
      domain = yield_range
    )
    
    # Plot the points and color code them based on the yield_upper column
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addCircleMarkers(
        data = filtered_data(),
        ~longitude, ~latitude,
        fillOpacity = 0.2,
        opacity = 0.3,
        color = "#000000",
        fillColor = ~color_pal(log10(yield_upper)+1),
        stroke = TRUE,
        radius = 5,
        weight = 1,
        popup = ~name
      ) %>% 
      addLegend(
        "bottomright",
        pal = color_pal,
        values = yield_range,
        title = "log yield (kt)"
      )
    
  })
  
  output$num_explosions <- renderText({
    paste("Number of explosions:", num_explosions())
  })
  
}

shinyApp(ui, server)