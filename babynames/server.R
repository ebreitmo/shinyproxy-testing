library(shiny)
library(dygraphs) # renderDygraph
library(stringr) # str_trim, str_to_title

load("babynames1974_2017final.rdata")

shinyServer(function(input, output) {
  
  output$dygraph_plot <- renderDygraph({
    
    dygraph_data<-as.data.frame(cbind(1974:2017, 
                                      as.numeric(dat[dat$firstname==str_trim(str_to_title(input$Name)) & dat$sex==input$Sex, -(1:2)])))
    main_lb<-""
    if (input$Name!="") {
      main_lb<-ifelse(input$Sex == "Male", 
                      paste("Boys named", str_trim(str_to_title(input$Name))), 
                      paste("Girls named", str_trim(str_to_title(input$Name))))
    } 
    
    dygraph(dygraph_data, main = main_lb) %>%

    dyAxis("x", label = "Year", rangePad=5)  %>%

    dySeries("V2", label = "Number of babies", strokeWidth=3, 
             color = ifelse(input$Sex == "Male", "#FF780E", "#703989")) %>%
        
    dyOptions(fillGraph = T, fillAlpha = 0.4, drawGrid = F, includeZero = T,
              drawPoints = T, pointSize=4, axisLabelWidth=40)  %>%
        
    dyHighlight(highlightCircleSize=8, highlightSeriesBackgroundAlpha = 1)

  })

})