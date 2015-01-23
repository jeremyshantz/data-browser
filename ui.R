
# UI.R
# The ui has three forms of widget input: two selectInputs, a slider, and a checkbox.
# It also outputs text, html, and a table.

library(shiny)

shinyUI(fluidPage(
    
    tags$head(
        tags$title('Waterloo Neighbourhood Browser'),
        tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
        tags$link(rel = "stylesheet", type = "text/css", href = "corrections.css")
    ),
    
    tags$img(src='logo.png', style="float:right;"),
    tags$h1("Waterloo Neighbourhood Browser"),    
    
    tags$div( 
        tags$p(
            'From Downtown to the Tech Park, from Clair Hills to West Hill, from the Rural West to the Rural East - the Waterloo Neighbourhood Browser is your source for city geo data.
            Browse through the city\'s wards and neighbourhoods while a random sample of addresses from the selected neighbourhood is plotted on the map below. 
            Adjust the slider to control the sample size. If you would prefer your data in tabular form, check the box and scroll down.',
            'Created with',
            tags$a('R', href='http://www.r-project.org/'),
            ' and ',
            tags$a('Shiny', href='http://shiny.rstudio.com/'),
            ' using data from ',
            tags$a('Open Data - City of Waterloo', href='http://www.waterloo.ca/en/opendata/'), '.', 
            tags$a('View the source', href='https://github.com/jeremyshantz/data-browser'), '.'
        )
    ),
    
    hr(),
    h1(textOutput('selecteddistrict')),
    fluidRow(class='well',
             
             column(2,
                    selectInput('ward', 'Ward', c(''), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL),
                    p('1. Select the city ward')
             ),     
             column(2,
                    selectInput('district', 'Neighbourhood', c(''), selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL),
                    p('2. Choose a neighbourhood in the ward')
             ),
             column(3,
                    sliderInput('points', 'Address Sample Size', value = 100, min = 1, max = 400, step = 1),
                    p('3. Slide to adjust the number of addresses to show from this neighbourhood')
             ),
             column(2,
                    checkboxGroupInput('opts',  'Options', c('Show data')),
                    p('4. View the addresses in a table (below the map)')
             ),
             column(3,
                    p(''),
                    p('')
             )
    ),
    
    hr(),
    
    htmlOutput('map'),
    dataTableOutput('locations')
    
))