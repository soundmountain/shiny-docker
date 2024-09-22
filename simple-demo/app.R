library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Interaktive Shiny App: Textanalyse"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("text", "Gib hier deinen Text ein:", ""),
      actionButton("analyze", "Text analysieren")
    ),
    mainPanel(
      textOutput("wordCount"),
      textOutput("charCount"),
      plotOutput("letterPlot"),
      plotOutput("frequencyPlot")
    )
  )
)

server <- function(input, output) {
  
  analyzeText <- reactive({
    if(input$analyze > 0) {
      text <- input$text
      words <- strsplit(text, "\\s+")
      numWords <- length(words[[1]])
      numChars <- nchar(gsub("\\s", "", text))  
      cleanText <- tolower(gsub("[^a-z]", "", text))
      letters <- strsplit(cleanText, "")[[1]]
      letterFreq <- table(letters)
      list(words = numWords, chars = numChars, splitWords = words, letterFrequency = letterFreq)
    }
  })
  
  output$wordCount <- renderText({
    analysis <- analyzeText()
    if(!is.null(analysis)) {
      paste("Anzahl der Wörter:", analysis$words)
    }
  })
  
  output$charCount <- renderText({
    analysis <- analyzeText()
    if(!is.null(analysis)) {
      paste("Anzahl der Buchstaben (ohne Leerzeichen):", analysis$chars)
    }
  })
  
  output$letterPlot <- renderPlot({
    analysis <- analyzeText()
    if(!is.null(analysis) && length(analysis$splitWords[[1]]) > 0) {
      wordList <- tolower(analysis$splitWords[[1]])
      firstLetters <- substring(wordList, 1, 1)
      letterData <- as.data.frame(table(firstLetters))
      ggplot(letterData, aes(x = firstLetters, y = Freq)) +
        geom_bar(stat = "identity", fill = "steelblue") +
        theme_minimal() +
        labs(title = "Häufigkeit der Anfangsbuchstaben", x = "Buchstabe", y = "Häufigkeit")
    }
  })
  
output$frequencyPlot <- renderPlot({
  analysis <- analyzeText()
  if(!is.null(analysis) && length(analysis$letterFrequency) > 0) {
    letterFreqData <- as.data.frame(analysis$letterFrequency)
    colnames(letterFreqData) <- c("Letter", "Frequency")
    ggplot(letterFreqData, aes(x = Letter, y = Frequency)) +
      geom_bar(stat = "identity", fill = "tomato") +
      theme_minimal() +
      labs(title = "Häufigkeit aller Buchstaben", x = "Buchstabe", y = "Häufigkeit")
  }
})

  
  observeEvent(input$analyze, {
    analyzeText()
  })
}

shinyApp(ui = ui, server = server)
