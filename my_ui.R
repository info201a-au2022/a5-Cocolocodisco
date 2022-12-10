library("tidyverse")
library("plotly")
source("my_server.R")

dataset <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Intro tab and tabPanel includes a title, description, and textOutput, image on the right side of the page




intro_bar <- tabPanel(
    # Title and description make it aesthetically pleasing
    "Introduction",
    h3("CO2 Emissions data in country United States, Canada, China, India, and Russia"),
    #put the image on the left side of the page and the text, and textOutput on the right side of the page
    fluidRow(
        column(6, offset = 0, h4("CO2 Emissions are the amount of carbon dioxide released into the atmosphere by human activities. Through years of burning fossil fuels, humans have increased the amount of carbon dioxide in the atmosphere. This has led to global warming and climate change. The data below shows the CO2 emissions information for the United States, Canada, China, India, and Russia from 1960 to 2020. ")
        , textOutput ("intro_text1"), textOutput ("intro_text2"), textOutput ("intro_text3"), textOutput ("intro_text4"), textOutput ("intro_text5"), textOutput ("intro_text6"), textOutput ("intro_text7" )),
        column(6, offset = 0, img(src = "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/ts/20201211042210/ri/1000/picture/2020/12/shutterstock_772541140.jpg", width = "100%"))
    )
)


# Bar graph tab for selected country from United States, Canada, China, India, and Russia

bar_tab <- tabPanel(
    "Bar Graph",
    sidebarLayout(
        sidebarPanel(
            selectInput("country", "Select a country", choices = c("United States", "Canada", "China", "India", "Russia")),
        ),
        mainPanel(
            plotlyOutput("bar_graph"),
        )
    )
)


# Create the UI for the application and add the tabs

ui <- fluidPage(
  titlePanel("CO2 Emissions"),
  tabsetPanel(
    intro_bar,
    bar_tab
  )
)






