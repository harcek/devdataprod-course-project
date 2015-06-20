# library(DT) # must install if (!require("DT")) devtools::install_github("rstudio/DT")
library(shiny)
library(ggplot2)

titanic_data <- read.csv("data/kaggle-titanic-train.csv", stringsAsFactors=FALSE)
titanic_data$Survived <- as.factor(titanic_data$Survived)
titanic_data_features <- titanic_data[c(-1,-2)] # subset by removing passenger id and survived
num_features <- sapply(titanic_data_features, is.numeric)
titanic_data_num_features <- titanic_data_features[,num_features]

simple_model <- glm(Survived ~ Pclass + Sex + Age, family = binomial(), data=titanic_data)
# new_data <- data.frame(Pclass=integer(1), Sex=character(1), Age=numeric(1), stringsAsFactors=FALSE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$colnames <- renderUI({
    selectInput("Feature", 
      "Select feature to plot against survival", 
      colnames(titanic_data_num_features),
      selected=1)
  })

  output$survivalPlot <- renderPlot({
    if (is.null(input$Feature)) {
      input$Feature <- "Age"
    }
    ggplot(data=titanic_data, aes_string(x=input$Feature,colour="Survived"))+geom_freqpoly()
  })
  
  output$prediction <- renderText({
    df_new <- data.frame(Pclass=c(as.numeric(input$modelPclass)), Sex=c(input$modelSex), Age=c(as.numeric(input$modelAge)), stringsAsFactors=FALSE)
    paste("Predicted survival probability is ", predict(simple_model, df_new, type="response"), "%")
  })

  # https://datatables.net/upgrade/1.10-convert
  output$view <- renderDataTable({
    titanic_data
  }, options = list(orderClasses = TRUE, pageLength = 10))

  output$summary <- renderPrint({
    summary(titanic_data)
  })
  
  output$str <- renderPrint({
    str(titanic_data)
  })
})