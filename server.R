shinyServer(function(input, output) {
  
  Data <- reactive({
    
    
    # input$file1 will be NULL initially. After the user selects and uploads a 
    # file, it will be a data frame with 'name', 'size', 'type', and 'datapath' 
    # columns. The 'datapath' column will contain the local filenames where the 
    # data can be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    df.raw <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
    # calculate term and pupil averages
    t1Av <- colMeans(df.raw[3:5])[1]
    t2Av <- colMeans(df.raw[3:5])[2]
    t3Av <- colMeans(df.raw[3:5])[3]
    df.raw$Av <- round(rowMeans(df.raw[3:5]),1)
    
    # reshape th data.frame for further analysis
    df.melt <- melt(df.raw, id.vars=c("Name","Gender"))
    colnames(df.melt) <- c("Name","Gender","Term","Mark")
    
    # get average boy and girl marks
    girls <-round(tapply(X = df.melt$Mark, INDEX = list(df.melt$Gender), FUN = mean)["F"],1)
    boys <-round(tapply(X = df.melt$Mark, INDEX = list(df.melt$Gender), FUN = mean)["M"],1)
    
    # create a list of data for use in rendering
    info <- list(df.raw=df.raw,df.melt=df.melt,t1Av=t1Av,t2Av=t2Av,t3Av=t3Av,girls=girls,boys=boys)
    return(info)
  })
  
  
  
  # allows pageability and number of rows setting
  myOptions <- reactive({  
    list(
      page=ifelse(input$pageable==TRUE,'enable','disable'),
      pageSize=input$pagesize
    ) 
  } )
  
  output$raw <- renderGvis({
    if (is.null(input$file1)) { return() }
    
    gvisTable(Data()$df.raw,options=myOptions())         
  })
  
  output$density <- renderPlot({
    if (is.null(input$file1)) { return() }
    print(ggplot(Data()$df.melt, aes(x=Mark, fill=Term)) + geom_density(alpha=.3))
    
  })
  
  output$genderDensity <- renderPlot({
    if (is.null(input$file1)) { return() }
    df.gender<- subset(Data()$df.melt,Term!="Av")
    str(df.gender)
    print(ggplot(df.gender, aes(x=Mark, fill=Gender)) + geom_density(alpha=.3))
    
    
  })
  
  output$sexDiff <- renderPrint({
    if (is.null(input$file1)) { return() }
    df.gender<- subset(Data()$df.melt,Term!="Av")
    aov.by.gender <- aov(Mark ~ Gender, data=df.gender)
    summary(aov.by.gender) 
  })
  
  output$caption1 <- renderText( {
    if (is.null(input$file1)) { return() }
    
    "Ms Twizzle's Class - Science Results"
  })
  
  output$caption2 <- renderText( {
    if (is.null(input$file1)) { return() }
    paste0("Average Mark  Term 1:",Data()$t1Av," Term 2:",Data()$t2Av," Term 3:",Data()$t3Av)
  })
  
  
  output$caption3 <- renderText( {
    if (is.null(input$file1)) { return() }
    paste0("Analysis of Variance by Gender - Boys Average Mark:",Data()$boys, "  Girls Average Mark:",Data()$girls)
  })
  
  output$notes2 <- renderUI( {
    if (is.null(input$file1)) { return() }
    HTML("The above graph shows the variation in pupils' marks by term. The annual spread
         will normally be greater as the example data is random and normally some pupils will
         tend to be better than others over each term")
    
  })
  
  output$notes3 <- renderUI( {
    if (is.null(input$file1)) { return() }
    HTML("The Analysis of Variance indicates whether there is a statistically significant
         difference between boys and girls in the class. With this 'fixed' data, there is a
         significant difference at the 5% level")
    
  })
  
})