#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
berry<- read.csv("/Users/angryboats/Desktop/MA 615/berries/blueberry.csv", header=T)
library(magrittr)
# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Blueberry"),

    # Sidebar
    sidebarLayout(
        sidebarPanel(
            sliderInput("Year",
                        "Year:",
                        min = 2015,
                        max = 2019,
                        value = 2019),
            selectInput("State", "Choose a state:", 
                        choices = c("ALABAMA", "ARKANSAS", "CALIFORNIA", "FLORIDA", "GEORGIA", "INDIANA", "MAINE", "MICHIGAN", "MISSISSIPPI", "NEW JERSEY", "NEW YORK", "NORTH CAROLINA", "OREGON", "OTHER STATES", "WASHINGTON" ))
        ),

        # Show the data and information that fits your choices
        mainPanel(
           dataTableOutput("view"),
           textOutput("ps")
        )
    )
)



# Define server
server <- function(input, output) {

    output$view <- renderDataTable({
        berry<- berry %>% filter((State==input$State) & (Year==input$Year))
        berry %<>% select(-1, -2, -3)
    })
    
    output$ps<- renderText({"* 0 in 'Value' column means there's no record or data avaliable"})
}

# Run the application 
shinyApp(ui = ui, server = server)
