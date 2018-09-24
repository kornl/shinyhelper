library(shiny)
library(dplyr)
library(shinyhelper)

# Minimal shiny example from https://shiny.rstudio.com/articles/basics.html
ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30) %>% helper(type = "markdown",
                                         content = "test")
    ),
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
  })
  
  observe_helpers(help_dir = "/home/kornl/git/shinyhelper/test", withMathJax = TRUE)
  
}

shinyApp(ui, server)