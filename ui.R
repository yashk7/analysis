shinyUI(pageWithSidebar(
  headerPanel("Uploaded File Analysis"),
  
  sidebarPanel(
    helpText("This app is shows how a user can update a csv file from their own hard drive for instant analysis.
             In the default case, it uses standard format school marks that could be used by many teachers
             Any file can be uploaded but analysis is only available
             if the data is in same format as the sample file, downloadable below
             "),
    a("Pupil Marks", href="http://dl.dropbox.com/u/25945599/scores.csv"),
    tags$hr(),
    fileInput('file1', 'Choose CSV File from local drive, adjusting parameters if necessary',
              accept=c('text/csv', 'text/comma-separated-values,text/csv')),
    
    checkboxInput('header', 'Header', TRUE),
    radioButtons('sep', 'Separator',
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 'Comma'),
    radioButtons('quote', 'Quote',
                 c(None='',
                   'Double Quote'='"',
                   'Single Quote'="'"),
                 'Double Quote'),
    tags$head(tags$style(type="text/css",
                         "label.radio { display: inline-block; margin:0 10 0 0;  }",
                         ".radio input[type=\"radio\"] { float: none; }"))
    
    ),
  mainPanel(
    tabsetPanel(
      tabPanel("Pupil Marks",
               h4(textOutput("caption1")),
               checkboxInput(inputId = "pageable", label = "Pageable"),
               conditionalPanel("input.pageable==true",
                                numericInput(inputId = "pagesize",
                                             label = "Pupils per page",value=13,min=1,max=25)),
               
               htmlOutput("raw"),
               value = 1),
      tabPanel("Term Details",
               h4(textOutput("caption2")),
               plotOutput("density"),
               htmlOutput("notes2"),
               value = 2),
      tabPanel("Gender difference",
               h4(textOutput("caption3")),
               plotOutput("genderDensity", height="250px"),
               verbatimTextOutput("sexDiff"),
               htmlOutput("notes3"),
               value = 3),
      id="tabs1")
    
    
  )
  ))
