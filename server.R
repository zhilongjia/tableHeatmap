

library(ggplot2)
library(DT)

function(input, output) {
    
    datasetInput <- reactive({
        validate(
            need(input$FCfile != 0, "Please select a file for input") 
        )
        inFile <- input$FCfile
        if (is.null(inFile)) return(NULL)
        readr::read_csv(inFile$datapath)
    })
    

    output$table <- DT::renderDataTable(DT::datatable({
        
        dat <- datasetInput()
        dat[,-1] <- round(dat[,-1], 3)
        tibble::column_to_rownames(dat)
    
    }, options = list(paging = FALSE, searching=FALSE,
                      columnDefs = list(list(width = '80%', targets = "_all"))
    ) ) %>% formatStyle(
        colnames(dat)[-1],
        backgroundColor = styleInterval(c(-1, -0.3, 0.3, 1), c('LimeGreen', 'Lime', 'white', '#F00000', '#A00000'))
    )
    )
}
