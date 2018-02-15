#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(magrittr)

# Define UI for application that draws a histogram
ui <- fluidPage(
                theme ="gallery.css",
                tags$head(
                    tags$link(rel = "stylesheet", type = "text/css",
                              href = "gallery.css")
                ),
                
                # Application title
                
                titlePanel(htmlOutput("current_process")),
                # Sidebar with a slider input for number of bins 
                navbarPage("My_Application",id = "My_Application",
                           tabPanel("Upload_data",id = "Upload_data",
                                    fileInput("file1", "Choose CSV File",
                                              multiple = TRUE,
                                              accept = c("text/csv",
                                                         "text/comma-separated-values,text/plain",
                                                         ".csv"))),
                           tabPanel("Normalisation",id="Normalisation",
                                    radioButtons("normalize_with",
                                                 label = "normalize_with",
                                                 choices = c("deseq2","voom"),
                                                 selected = "deseq2")
                                    ),
                           tabPanel("Component 3")
                )
)


# Define server logic required to draw a histogram
server <- function(input, output, session) {
    variables = reactiveValues(current_task = "<b>Welcome, 
                               <br> bla bla bla <br>
                                   Please upload data below<b>")
    df<- reactive({
        read.csv(input$file1$datapath)
    })
    
    
    
    observeEvent(input$file1, {
        variables$current_task <<- "Uploaded the data ..."
        updateTabsetPanel(session,"My_Application",
                          selected = "Normalisation")
    })
    output$current_process <- renderText(paste0(":~$",
                                                variables$current_task))
}

# Run the application 
shinyApp(ui = ui, server = server)

