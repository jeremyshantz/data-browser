# Server.R loads our addresses data set.
# It calculates values for the Wards and Districts drop down lists
# It receives input from both drop down lists, a slider, and a checkbox.
# The selection of the Ward drop down list drives the values available 
#   in the District drop down list..
# The selection of the Distric second drop down list changes the map by 
#   calculating a random sample of geo points in the selected district and 
#   generating a plot. If the checbox is checked, a table of the sample is 
#   also displayed.

library(shiny)
library(googleVis)
library(dplyr)

# Load our dataset
address <- read.csv('AddressPoints.csv')

# Concatenate lat angd long 
address$latlong <- paste(address$LATITUDE, address$LONGITUDE, sep=":")

# Clean for display
address <- select(address, -OBJECTID, -LATITUDE, -LONGITUDE)
row.names(address) <- NULL
names(address) <- c('Address', 'Street', 'Ward', 'District', 'Coordinates')

# List of unique Wards
wards <- sort(unique(address$Ward[!is.na(address$Ward) & address$Ward > 0]))

shinyServer(
    function(input, output, session) {
        
        # Set the values for the Ward drop down list
        updateSelectizeInput(session, 'ward', choices = wards, server = FALSE)
        
        # update District drop down values when Ward changes
        observe({
            
            # use input$ward to filter the data set; generate list of unique districts in the ward
            district <- sort(as.character(unique(address[address$Ward == input$ward & !is.na(address$Ward), 'District'])))
            updateSelectizeInput(session, 'district', choices = district, server = FALSE)
        })
        
        # Calculates geo points in the district, randomly sampling them based on input$points
        # Shared method called by renderGvis and renderTable
        getData <- reactive({
            
            neighbourhood <- address[address$District == input$district,]
            
            n <- input$points
            len <- nrow(neighbourhood) 
            if (len < n) {
                n <- len  - 1
            }
            
            neighbourhood <- neighbourhood[sample(1:len, n), ]
            row.names(neighbourhood) <- NULL
            neighbourhood
        })
        
        # output the geo points as a data table
        output$locations <- renderDataTable ({
            if ( length(input$opts) == 0 ) {
                NULL
            } else {
                getData()    
            }
        })
        
        # output the geo points as a map
        output$map <- renderGvis({ 
            gvisMap(getData(), "Coordinates" , "Address", 
                        options=list(showTip=TRUE, 
                                     showLine=TRUE, 
                                     lineWidth = 70,
                                     height='900',
                                     enableScrollWheel=TRUE,
                                     mapType='hybrid', 
                                     useMapTypeControl=TRUE))
        })
        
        # Display the name of the selection district
        output$selecteddistrict <- renderText({  
           input$district
        })  
         
    }
)