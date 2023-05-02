library(shiny)
library(ggplot2)
library(datasets)
library(magrittr)


ui <- fluidPage(
  
  # Title
  titlePanel(strong("Iris Data Visualization [Ishaan Shrivastava - B20AI013]")),
  
  # Histograms of all the properties
  mainPanel(
    plotOutput("histograms", height=400),
    plotOutput("scatterplot", height=400),
    plotOutput("violinboxplot", height=400),
  ),
  
  # Scatter plot of data points with each species in different color
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("height_histograms", "Height (histograms)", min = 200, max = 380, value = 380),
      sliderInput("width_histograms", "Width (histograms)", min = 200, max = 1200, value = 500),
      br(),
      br(),
      sliderInput("height_scatterplot", "Height (scatter plot)", min = 200, max = 325, value = 325),
      sliderInput("width_scatterplot", "Width (scatter plot)", min = 200, max = 1200, value = 500),
      br(),
      br(),
      sliderInput("height_violinplot", "Height (violin plot)", min = 200, max = 400, value = 350),
      sliderInput("width_violinplot", "Width (violin plot)", min = 200, max = 1200, value = 500),
      br(),
      br(),
      br(),
      
      strong(h2("Histograms of all the properties")),
      selectInput(inputId = "species", label = "Select a species (for histogram):",
                  choices = unique(iris$Species),
                  selected = unique(iris$Species)[1], multiple=TRUE),
      fluidRow(
        column(3, selectInput("color1", "Select a color (Sepal Length):", c("red", "blue", "green", "black"))),
        column(3, selectInput("color2", "Select a color (Sepal Width):", c("blue", "red", "green", "black"))),
        column(3, selectInput("color3", "Select a color (Petal Length):", c("green", "blue", "red", "black"))),
        column(3, selectInput("color4", "Select a color (Petal Width):", c("black", "blue", "green", "red")))
      ),
      fluidRow(
        column(3, numericInput(inputId = "bin_SepalLength", label = "Bin size for Sepal Length:", value = 0.2),),
        column(3, numericInput(inputId = "bin_SepalWidth", label = "Bin size for Sepal Width:", value = 0.2),),
        column(3, numericInput(inputId = "bin_PetalLength", label = "Bin size for Petal Length:", value = 0.1),),
        column(3, numericInput(inputId = "bin_PetalWidth", label = "Bin size for Petal Width:", value = 0.1),),
      ),
      br(),
      br(),
      br(),
      
      
  
      
      
      strong(h2("Scatter plot of data points with each species in a different color")),     
      p("Color for selected species:"),
      fluidRow(
        column(3, selectInput("color_setosa", "Select a color (Setose):", c("black", "red", "green", "red"))),
        column(3, selectInput("color_virginica", "Select a color (Virginica):", c("blue", "red", "green", "black"))),
        column(3, selectInput("color_versicolor", "Select a color (Versicolor):", c("red", "blue", "green", "black"))),
      ),
      
      checkboxGroupInput("species_scatterplot", "Select species:",
                         choices = unique(iris$Species),
                         selected = unique(iris$Species)),
      selectInput(inputId = "y_axis", label = "Select y-axis:",
                  choices = colnames(iris)[-5],
                  selected = colnames(iris)[2]),
      selectInput(inputId = "x_axis", label = "Select x-axis:",
                  choices = colnames(iris)[-5],
                  selected = colnames(iris)[1]),
    ),
    mainPanel(
    )
  ),
  
)



server <- function(input, output) {
  
  # Load the Iris data
  data(iris)
  
  # Histograms of all the properties
  output$histograms <- renderPlot({
    par(mfrow=c(2,2)) # Set up a 2x2 grid of plots
    subset_iris <- iris[iris$Species == input$species,]
    range1 <- seq(min(iris$Sepal.Length), max(iris$Sepal.Length), by = input$bin_SepalLength)
    range2 <- seq(min(iris$Sepal.Width), max(iris$Sepal.Width), by = input$bin_SepalWidth)
    range3 <- seq(min(iris$Petal.Length), max(iris$Petal.Length), by = input$bin_PetalLength)
    range4 <- seq(min(iris$Petal.Width), max(iris$Petal.Width), by = input$bin_PetalWidth)
    hist(subset_iris$Sepal.Length, main="Sepal Length", xlab="Length (cm)", col=input$color1, breaks = range1)
    hist(subset_iris$Sepal.Width, main="Sepal Width", xlab="Width (cm)", col=input$color2, breaks = range2)
    hist(subset_iris$Petal.Length, main="Petal Length", xlab="Length (cm)", col=input$color3, breaks = range3)
    hist(subset_iris$Petal.Width, main="Petal Width", xlab="Width (cm)", col=input$color4, breaks = range4)
  }, 
  width=reactive(input$width_histograms),
  height=reactive(input$height_histograms),)
  
  # Scatter plot of data points with each species in different color
  output$scatterplot <- renderPlot({
    # filter by selected species
    iris_filtered <- iris[iris$Species %in% input$species_scatterplot,]
    
    # create scatterplot with selected color and filtered species
    ggplot(iris_filtered, aes(x = iris_filtered[, input$x_axis], y = iris_filtered[, input$y_axis], color=Species)) +
      geom_point() +
      labs(
            x = input$x_axis,
           y = input$y_axis) + 
      scale_color_manual(values = c(setosa = input$color_setosa, virginica = input$color_virginica, versicolor = input$color_versicolor))
  }, 
  width=reactive(input$width_scatterplot),
  height=reactive(input$height_scatterplot),)
  
  # Violin or Box plot for separate species in a single plot
  output$violinboxplot <- renderPlot({
    ggplot(iris, aes(x=Species, y=Petal.Length)) + 
      geom_violin(trim=FALSE) + 
      geom_boxplot(width=0.1, fill="white") + 
      xlab("") + ylab("Petal Length (cm)")
  }, 
  width=reactive(input$width_violinplot),
  height=reactive(input$height_violinplot),)
}




shinyApp(ui, server)