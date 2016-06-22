
# The user-interface definition of the Shiny web app.
library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
  navbarPage("Baby Names", 
             # multi-page user-interface that includes a navigation bar.
             tabPanel("Data",
                      sidebarPanel(
                        sliderInput("range", 
                                    "Year Range of Names:", 
                                    min = 1880,
                                    max = 2016,
                                    value = c(1880, 2016)),
                        textInput("name", "Name", value = "", width = NULL, placeholder = NULL),
                        checkboxInput("exact", "Exact Match", TRUE),
                        actionButton(inputId = "submit", 
                                     label = "Submit")
                      ),
                      mainPanel(
                        tabsetPanel(
                          tabPanel(p(icon("table"), "Dataset"),
                                   h4('Name', align = "center"),
                                   textOutput("babyname"),
                                   dataTableOutput(outputId="dTable")
                          ), 
                          tabPanel(p(icon("line-chart"), "Visualization"),
                                   h4('Name Frequency by Year', align = "center"),
                                   textOutput("babyname2"),
                                   showOutput("NamesByYear", "nvd3")
                          ) 
                        )
                      )     
             ), # end of "Explore Dataset" tab panel
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("about.md")
                      )
             ) # end of "About" tab panel
  )  
)