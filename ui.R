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
        checkboxGroupInput('opts',  'Options', c('Show data'))
        
    ),
    mainPanel(
        
        # http://www.waterloo.ca/en/opendata/ Open Data - City of Waterloo
        h1(textOutput('selecteddistrict')),
        htmlOutput('map'),
        tableOutput('locations')
    )
))