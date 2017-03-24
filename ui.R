
library(ggplot2)

fluidPage(
    titlePanel("Heatmaping DataTable"),
    
    fluidRow(
        column(4,
               fileInput("FCfile", "Choose CSV File",
                         accept = c("text/csv","text/comma-separated-values,text/plain",".csv")
               )
        )
    ),

    fluidRow(
        DT::dataTableOutput("table")
    )
)
