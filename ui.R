# library(DT)
library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("Kaggle Titanic Dataset Exploration"),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      uiOutput("colnames"),
      helpText("Numeric features only allowed*"),
#    ),
#    sidebarPanel(
      helpText("Predict probability based on simple model using passenger class, sex and age"),
      selectInput("modelPclass", 
          "Passenger class", 
          c("1st ~ Upper" = 1, "2nd ~ Middle" = 2, "3rd ~ Lower" = 3), 
          selected = 1
      ),
      selectInput("modelSex", 
                  "Passenger sex", 
                  c("male", "female"), 
                  selected = 1
      ),
      textInput("modelAge", "Passenger age", "30"),
      textOutput("prediction")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("survivalPlot")),
        tabPanel("Browse", dataTableOutput("view")),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Str", verbatimTextOutput("str"))
      )
    )
  )
))