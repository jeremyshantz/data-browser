# UI.R
# The ui has three forms of widget input: two selectInputs, a slider, and a checkbox.
# It also outputs text, html, and a table.
#

library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Waterloo Neighbourhood Browser"),    
    
    sidebarPanel(
        selectInput('ward', 'Ward', c(''), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL),
        selectInput('district', 'District', c(''), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL),
        sliderInput('points', 'Address Sample Size', value = 100, min = 1, max = 400, step = 1,),
        checkboxGroupInput('opts',  'Options', c('Show data')),
        tags$div(
            h2('Documentation'),            
            tags$p('this is some text in the side bar'),
            tags$p('this is some text in the side bar'),
            tags$p('this is some text in the side bar'),
            h3('Documentation'),
            tags$p('this is some text in the side bar'),
            tags$p('this is some text in the side bar'),
            tags$p('this is some text in the side bar'),
            tags$p('this is some text in the side bar')
            
            )
        
    ),
    mainPanel(
        tags$img(src='logo.png', class='pull-right'),
    tags$div( 
       
        tags$p('Using data from', 
               tags$a('Open Data - City of Waterloo', href='http://www.waterloo.ca/en/opendata/'),
               'we have created this.'
               )
        
    ),
  
        h1(textOutput('selecteddistrict')),
        htmlOutput('map'),
        dataTableOutput('locations')
    )
))