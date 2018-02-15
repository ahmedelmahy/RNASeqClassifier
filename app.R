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
library("BiocParallel")
source("www/config_df.R")
#source("www/functions.R")
options(shiny.trace=TRUE)
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
                                    span("
                                         We assume the file to be a csv file, columns are genes
and rows are the sample names , the first column is sample ID and there is additional column
called class.
                                         "),
                                    fileInput("file1", "Choose CSV File",
                                              multiple = TRUE,
                                              accept = c("text/csv",
                                                         "text/comma-separated-values,text/plain",
                                                         ".csv"))),
                           tabPanel("Normalisation",id="Normalisation",
                                    radioButtons("normalize_with",
                                                 label = "normalize_with",
                                                 choices = c("deseq2","voom"),
                                                 selected = "deseq2"),
                                    actionButton(
                                        inputId = "normalize_button",
                                        label = "Normalize Data"
                                    )
                                    ),
                           tabPanel("Settings",id = "Settings",
                                    selectInput("config_variable", "choose variable ?",
                                                choices = colnames(config_df)),
                                    textInput("config_value", "value"),
                                    actionButton(
                                        "config_update",
                                        label = "update"
                                    )
                                    
                                    
                                    
                                    
                                    )
                )
)


# Define server logic required to draw a histogram
server <- function(input, output, session) {
    normalise <- function(data, method){
        if (method == "deseq"){
            
            
            return(d)
            
        } else if(method == "voom"){
            
        }
        
        
    }    
variables = reactiveValues(current_task = "<b>Welcome, 
                               <br> bla bla bla <br>
                                   Please upload data below<b>",
                               normalized_df = 0)
    df<- reactive({
        read.csv(input$file1$datapath,header = TRUE ,
                 row.names = 1)
    })
    
    
    observeEvent(input$config_variable,{
        updateTextInput(session, "config_value", value = 
        paste(config_df[,which(colnames(config_df) == input$config_variable)]))
        })
    observeEvent(input$normalize_button,{
        variables$current_task <<- paste0(dim(df()))
        normaliv <- function (du = df() ){
        class <- factor(du$class)
        df2 <- du[,-which(colnames(du) == "class")]
        dat = t(df2)
        dds <- DESeqDataSetFromMatrix(countData = dat,
                                      colData = DataFrame(class),
                                      design= ~ class)
        dds <- DESeq(dds,parallel=TRUE , BPPARAM=MulticoreParam(24))
        res <- results(dds)
        res_sel <- res [which(res$padj< config_df$padj_max & 
                                  abs(res$log2FoldChange)>=config_df$lfc_min),]
        
        genes <- res_sel@rownames
        d <- dds[genes,]
        d <- as.data.frame(t(counts(d ,
                                    normalized = TRUE)))
        d$class <- class
        return(d)
        }
        variables$normalized_df <<- normaliv(df())
            #normalise(data = df(), method = input$normalize_with )
        variables$current_task <<- paste0("normalizsed ! and dim of normalized_df is ",
                                dim(variables$normalized_df))

        
    })
    
    observeEvent(input$config_update,{
        config_df[,which(
            colnames(config_df) == input$config_variable)] <<- input$config_value
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

