library(shiny)
library(ggplot2)
library(plotly)

# Interface Utilisateur (frontend)
ui <- fluidPage(

    titlePanel('Clustering des données par K-Means'),

    sidebarLayout(
        sidebarPanel(
            selectInput('x', "Sélectionnez la variable an axe X :", names(iris)),
            selectInput('y', "Sélectionnez la variable an axe y :", names(iris)),
            numericInput('n_clusters', 
                         'Sélectionnez le nombre de clusters :', 
                         value = 3, min = 2, max = 7)
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("scatter_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$scatter_plot <- renderPlot({
        iris$Species <- NULL
        model <- kmeans(iris, centers = input$n_clusters, nstart = 20)
        iris_selected <- iris[, c(input$x, input$y)]
        plot(iris_selected, col = as.factor(model$cluster), pch = 20, cex = 3)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
