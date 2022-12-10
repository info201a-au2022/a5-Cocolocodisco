library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("tidyverse")

dataset <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# create a new dataset to only include the United States, Canada, China, India, and Russia

dataset <- dataset %>% 
    filter(country == "United States" | country == "Canada" | country == "China" | country == "India" | country == "Russia")

# filter the average co2 emission for the United States in 2015

co2_us_2020 <- dataset %>% 
    filter(country == "United States") %>% 
    filter(year == 2020) %>% 
    summarise(mean(co2))

# filter the average co2 emission for the United States in 1960

co2_us_1960 <- dataset %>% 
    filter(country == "United States") %>% 
    filter(year == 1960) %>% 
    summarise(mean(co2))

# calculate the percent change in co2 emissions for co2_us_2020 and co2_us_1960

percent_change <- ((co2_us_2020 - co2_us_1960) / co2_us_1960) * 100



server <- function(input, output){

#output a renderText of the average co2 emissions for theses countries in 2020, paste it in the intro tab

output$intro_text1 <- renderText({
    dataset %>% 
        filter(year == 2020) %>% 
        summarise(mean(co2)) %>% 
        paste("-The average CO2 emissions for the United States, Canada, China, India, and Russia in 2020 was", ., "metric tons per capita.")
})

#output a renderText of the average co2 emissions for theses countries in 1960, paste it in the intro tab

output$intro_text2 <- renderText({
    dataset %>% 
        filter(year == 1960) %>% 
        summarise(mean(co2)) %>% 
        paste("-The average CO2 emissions for the United States, Canada, China, India, and Russia in 1960 was", ., "metric tons per capita.")
})

#output a renderText of the location of the max co2 emissions for theses countries in 2020, paste it in the intro tab

output$intro_text3 <- renderText({
    dataset %>% 
        filter(year == 2020) %>% 
        filter(co2 == max(co2)) %>% 
        select(country) %>% 
        paste("-The country with the highest CO2 emissions in 2020 was", .)
})

#output a renderText of the location of the min co2 emissions for theses countries in 1960, paste it in the intro tab

output$intro_text4 <- renderText({
    dataset %>% 
        filter(year == 1960) %>% 
        filter(co2 == min(co2)) %>% 
        select(country) %>% 
        paste("-The country with the lowest CO2 emissions in 1960 was", .)
})

#output a renderText of average co2 emissions in United States in 2020, paste it in the intro tab

output$intro_text5 <- renderText({
    dataset %>% 
        filter(country == "United States") %>% 
        filter(year == 2020) %>% 
        summarise(mean(co2)) %>% 
        paste("-The average CO2 emissions for the United States in 2020 was", ., "metric tons per capita.")
})

#output a renderText of average co2 emissions in United States in 1960, paste it in the intro tab

output$intro_text6 <- renderText({
    dataset %>% 
        filter(country == "United States") %>% 
        filter(year == 1960) %>% 
        summarise(mean(co2)) %>% 
        paste("-The average CO2 emissions for the United States in 1960 was", ., "metric tons per capita.")
})

#output a renderText of the percent change in co2 emissions for the United States in 2020 and 1960, paste it in the intro tab

output$intro_text7 <- renderText({
    percent_change %>% 
        paste("-The percent change in CO2 emissions for the United States from 1960 to 2020 was", ., "%.")
})


# output a bar graph of average co2 emissions across for inputted country, color the bars red

output$bar_graph <- renderPlotly({
    dataset %>% 
        filter(country == input$country) %>% 
        ggplot(aes(x = year, y = co2, fill = country)) +
        geom_bar(stat = "identity") +
        scale_fill_manual(values = "red") +
        labs(title = "Average CO2 Emissions Across Countries in years", x = "Year", y = "CO2 Emissions (metric tons per capita)") +
        theme(plot.title = element_text(hjust = 0.5))
})
}

