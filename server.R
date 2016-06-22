library(shiny)

# Load data processing file
source("data.R")

# Shiny server
shinyServer(
  function(input, output) {
    babyname <- eventReactive(input$submit, {
      paste("You have selected:", input$name)
    })
    babyname2 <- eventReactive(input$submit, {
      paste("You have selected:", input$name)
    }) 
    output$babyname <- renderText({ 
      babyname()
    })
    
    output$babyname2 <- renderText({ 
      babyname2()
    })


    # Prepare dataset
    dataTable <- eventReactive(input$submit,{
      groupByName(src, input$range[1], input$range[2], input$name, input$exact)
    })
    
    dataTableByName <- eventReactive(input$submit,{
      groupByName(src, input$range[1], input$range[2], input$name, input$exact)
    })
    
    # Render data table
    output$dTable <- renderDataTable({
      dataTable()
    })
    
    output$NamesByYear <- renderChart({
     plotNamesCountByYear(dataTableByName())
    })
    
  } # end of function(input, output)
)