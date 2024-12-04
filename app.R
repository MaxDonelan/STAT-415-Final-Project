#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(readr)

weather <- read_csv("weather.csv")

shiny_weather <- list("CO 2022" = subset(weather, `Parameter Name` == "Carbon monoxide" & Year == 2022)$`Arithmetic Mean`,
                      "CO 2023" = subset(weather, `Parameter Name` == "Carbon monoxide" & Year == 2023)$`Arithmetic Mean`,
                      "Ozone 2022" = subset(weather, `Parameter Name` == "Ozone" & Year == 2022)$`Arithmetic Mean`,
                      "Ozone 2023" = subset(weather, `Parameter Name` == "Ozone" & Year == 2023)$`Arithmetic Mean`,
                      "SO2 2022" = subset(weather, `Parameter Name` == "Sulfur dioxide" & Year == 2022)$`Arithmetic Mean`,
                      "SO2 2023" = subset(weather, `Parameter Name` == "Sulfur dioxide" & Year == 2022)$`Arithmetic Mean`,
                      "Average Daily Temperature 2022" = subset(weather, `Parameter Name` == "Outdoor Temperature" & Year == 2022)$`Arithmetic Mean`,
                      "Average Daily Temperature 2023" = subset(weather, `Parameter Name` == "Outdoor Temperature" & Year == 2023)$`Arithmetic Mean`,
                      "Wind Direction 2022" = subset(weather, `Parameter Name` == "Wind Direction - Resultant" & Year == 2022)$`Arithmetic Mean`,
                      "Wind Direction 2023" = subset(weather, `Parameter Name` == "Wind Direction - Resultant" & Year == 2023)$`Arithmetic Mean`,
                      "Wind Speed 2022" = subset(weather, `Parameter Name` == "Wind Speed - Resultant" & Year == 2022)$`Arithmetic Mean`,
                      "Wind Speed 2023" = subset(weather, `Parameter Name` == "Wind Speed - Resultant" & Year == 2023)$`Arithmetic Mean`)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Shiny app for weather data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("cid", "Select the column", choices = names(shiny_weather)),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 12)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot")
    ) 
  )
)

# Define server logic required to draw a histogram and pie plot

server <- function(input, output) {
  
  output$Plot <- renderPlot({
    
    
    x <- shiny_weather[[input$cid]]
    
    
    # draw the histogram with the specified number of bins for variable columns
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    titl <- paste("Histogram of", input$cid, sep = " ")
    hist(x, breaks = bins, col = 'orange', border = 'white', main = titl) 
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

