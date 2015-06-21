---
title       : Developing Data Products Course Project
subtitle    : What would be your chance to survive Titanic shipwreck
author      : Daniel Harcek
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

<!-- Slide 1 -->

### Developing Data products Course Project

# What would be your chance to survive Titanic shipwreck?

April 15, 1912, early morning.
RMS Titanic collided with an iceberg during her maiden voyage from Southampton, UK, to New York City, US.
<br />The largest ship afloat at the time sank. Only 722 out of 2224 passengers and crew survived. 
<br />
## What would your fate be?

--- .class #id 

<!-- Slide 2 -->
Chance to survive is computed based on simple glm model trained on dataset used in a [Kaggle Titanic Competition](https://www.kaggle.com/c/titanic/data).
<br />
<br />
```
simple_model <- glm(Survived ~ Pclass + Sex + Age, family = binomial(), data=titanic_data)
```

--- .class #id

<!-- Slide 3 -->
## Survive or die?

Enter your age, sex and socioeconomic status (lower, middle, upper) and see your predicted survival probability.
<br />
<br />
```
output$prediction <- renderText({
    df_new <- data.frame(Pclass=c(as.numeric(input$modelPclass)), Sex=c(input$modelSex), Age=c(as.numeric(input$modelAge)), stringsAsFactors=FALSE)
    paste("Predicted survival probability is ", predict(simple_model, df_new, type="response"), "%")
  })
```

--- .class #id 

<!-- Slide 4 -->
In addition you can explore selected predictors against survivalship.
<br />
<br />
```
  output$survivalPlot <- renderPlot({
    if (is.null(input$Feature)) {
      input$Feature <- "Age"
    }
    ggplot(data=titanic_data, aes_string(x=input$Feature,colour="Survived"))+geom_freqpoly()
  })
```

--- .class #id 

<!-- Slide 5 -->
Try the app:  https://danielharcek.shinyapps.io/titanic_app
<br />
Data credits: Kaggle
