

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

        tibble::column_to_rownames(dat)
    
    }, options = list(paging = FALSE, searching=FALSE, colReorder = TRUE,
                      dom = 'Bfrtip', buttons = I('colvis'),
                     columnDefs = list(list(width = '1', targets = "_all"))
    ), extensions = c('ColReorder', 'Buttons') ) %>% formatStyle(
        colnames(dat)[-1], 
        backgroundColor = styleInterval(c(-2, -1, -0.3, 0.3, 1, 2), c('DarkGreen', 'LimeGreen', 'Lime', 'Grey', 'LightCoral', 'Red', 'DarkRed'))
    ) %>%  formatRound(colnames(dat)[-1], 3)
    )
}
