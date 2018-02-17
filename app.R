source("www/loading_libraries.R")

options(shiny.trace=TRUE)
normalized_df <- data.frame()
read_df <- data.frame()
load("normalized_df2.rda")
splited_df_list <- list(train_x = data.frame(), train_y = vector(),
                        test_x = data.frame(), test_y = vector())
model_list <<- list()
# Define UI for application that draws a histogram
ui <- fluidPage(
                theme ="gallery.css",
                tags$head(tags$link(rel = "stylesheet", type = "text/css",href = "gallery.css")),
                
                titlePanel(htmlOutput("current_process")),
                
                navbarPage("My_Application",id = "My_Application",
                           tabPanel("Upload_data",
                                    span(text_read),
                                    fileInput("file1", "Choose CSV File", multiple = TRUE,accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                                    HTML("Choose: <br> (1) if columns are genes and rows are the sample names , the first column is sample ID and there is additional column
                                         called class <br> (2) if bla bla bla format"),
                                    radioButtons("format_with", label = "format_with", choices = c(1,2), selected = 1),
                                    actionButton(inputId = "read_button", label = "Read Data")),
                           
                           tabPanel("Normalisation",
                                    radioButtons("normalize_with", label = "normalize_with", choices = c("deseq2","voom"), selected = "deseq2"),
                                    actionButton(inputId = "normalize_button",label = "Normalize Data")),
                           
                           tabPanel("Split data",
                                    radioButtons("split_with",label = "Split data into train and test ?",choices = c("yes","no"),selected = "yes"),
                                    actionButton(inputId = "split_button", label = "OK")),
                           
                           tabPanel("Compare models",
                               fluidRow(
                                    column(8, 
                                           selectInput("run_with",label = "select important genes with",choices = c("RF_up_sampling","RF_smote_sampling","glm_up_sampling","glm_smote_sampling")),
                                           actionButton(inputId = "add_model_button", label = "Add model"),
                                           actionButton(inputId = "remove_model_button", label = "Remove model")),
                                    column(12,plotOutput("roc")))),
                           
                           tabPanel("Select genes"),
                                    
                           
                           
                           tabPanel("Settings",id = "Settings", 
                                    selectInput("config_variable", "choose variable ?",choices = colnames(config_df)),
                                    textInput("config_value", "value"),
                                    actionButton("config_update",label = "update"))))

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
server <- function(input, output, session) {
#-------------------------------------------------------------------------------
    variables = reactiveValues(current_task = text_welcome)
#-------------------------------------------------------------------------------
# Buttons
    observeEvent(input$read_button,{
        read_df <<- readv(input$file1$datapath,input$format_with)
        updateTabsetPanel(session,"My_Application", selected = "Normalisation")
        
    })    
    observeEvent(input$normalize_button,{
        #normalized_df <<- normaliv(read_df, input$normalize_with)
        normalized_df <<- normalized_df2
        updateTabsetPanel(session,"My_Application", selected = "Split data")
    })
    
    observeEvent(input$split_button,{
        splited_df_list <<- splitv(normalized_df, input$split_with)
        updateTabsetPanel(session,"My_Application", selected = "Compare models")
    })
    
    observeEvent(input$add_model_button,{
        model_list[[length(model_list)+1]] <<- runv(splited_df_list,input$run_with)
        output$roc <- renderPlot(plot_multipe_rocs(model_list))
    })
    
    observeEvent(input$remove_model_button, {

        for (i in 1 : length(model_list)){
            if (model_list[[i]]$modelInfo$label == input$run_with){
                model_list <<- model_list[-i]
            }
        }
        output$roc <- renderPlot(plot_multipe_rocs(model_list))
        
    })
    
    
    
    # settings button
    observeEvent(input$config_update,{
        config_df[,which(
            colnames(config_df) == input$config_variable)] <<- input$config_value
    })
    
    observeEvent(input$config_variable,{
        updateTextInput(session, "config_value", value = 
                            paste(config_df[,which(colnames(config_df) == input$config_variable)]))
    })
    #---------------------------------------------------------------------------
    output$current_process <- renderText(paste0(":~$",
                                                variables$current_task))
}

# Run the application 
shinyApp(ui = ui, server = server)

