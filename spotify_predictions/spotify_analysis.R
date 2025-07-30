# loading libraries
library(readr)
library(tidyverse)
library(ggplot2)
library(lubridate) 

# Dataset: https://www.kaggle.com/code/joebeachcapital/top-10000-songs-eda-models
spotify_data <- read.csv('top_10000_1960-now.csv')

# filtering data
spotify_data_filtered <- spotify_data %>%
  select(Track.Name, Popularity, Danceability, Energy, Loudness, Tempo, Acousticness,
         Instrumentalness, Liveness, Speechiness, Valence, Track.Duration..ms.,
         Album.Release.Date, 
         Explicit            
  ) %>%
  mutate(Release.Year = year(ymd(Album.Release.Date))) %>%
  mutate(Explicit = as.factor(Explicit)) %>%
  select(-Album.Release.Date) %>% 
  drop_na()

#creating test and train data
set.seed(123)
n <- nrow(spotify_data_filtered)
train_index <- sample(1:n, size = 0.8 * n)
train_data <- spotify_data_filtered[train_index, ]
test_data <- spotify_data_filtered[-train_index, ]

model_reg <- lm(Popularity ~ Danceability + Energy + Loudness + Tempo + Acousticness +
                  Instrumentalness + Liveness + Speechiness + Valence + Track.Duration..ms. +
                  Release.Year +      
                  Explicit,           
                data = train_data)

#prediction vs actuals
predictions <- predict(model_reg, newdata = test_data)
head(predictions)

actuals <- test_data$Popularity

mae <- mean(abs(predictions - actuals))
mae


summary(model_reg)
#Top predictors: Release year and Danceability are most important factors for song popularity among all variables


# Popularity vs Danceability
ggplot(spotify_data_filtered, aes(x = Danceability, y = Popularity)) +
  geom_point(alpha = 0.3, size=0.8) +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Popularity vs Danceability",
       x = "Danceability",
       y = "Popularity") +
  theme_minimal() +
  coord_cartesian(xlim = c(0, 1), ylim = c(0, 100))


#Popularity vs release year
ggplot(spotify_data_filtered, aes(x = Release.Year, y = Popularity)) +
  geom_point(alpha = 0.3, size=0.8) +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Popularity vs Release.Year",
       x = "Release.Year",
       y = "Popularity") +
  theme_minimal() +
  coord_cartesian(xlim = c(min(spotify_data_filtered$Release.Year), max(spotify_data_filtered$Release.Year)),
                  ylim = c(0, 100))


glimpse(spotify_data_filtered)

#creating random test data
new_test_data <- data.frame(
  Popularity = c(85, 50, 96, 22, 69),
  Danceability = c(0.421, 0.999, 0.812, 0.123, 0.659),
  Energy = c(0.571, 0.753, 0.865, 0.668, 0.777),
  Loudness = c(-10.105, -4.295, -2.179, -8.312, -9.999),
  Tempo = c(211.458, 147.45, 71.921, 21.11, 65.800),
  Acousticness = c(0.01501, 0.01227, 0.56250, 0.56855, 0.99500),
  Instrumentalness = c(1.12e-01, 2.12e-05, 1.01e-06, 5.08e-05, 7.29e-05),
  Liveness = c(0.4089, 0.1370, 0.3380, 0.9384, 0.1890),
  Speechiness = c(0.0420, 0.1190, 0.4405, 0.1690, 0.0087),
  Valence = c(0.9040, 0.7700, 0.5560, 0.6330, 0.4470),
  Track.Duration..ms. = c(216288, 117120, 315533, 233650, 433720),
  Album.Release.Date = c("1992-08-03", "2009-10-23", "1999-01-12", "2014-10-20", "2023-05-01"),
  Explicit = c("false", "false", "true", "false", "true") 
) %>%
  mutate(Release.Year = year(ymd(Album.Release.Date))) %>%
  mutate(Explicit = as.factor(Explicit)) %>%
  select(-Album.Release.Date) 

#prediction vs actuals
predictions_new_test_data <- predict(model_reg, newdata = new_test_data)
actuals_new_test_data <- new_test_data$Popularity
mae_new_test_data <- mean(abs(predictions_new_test_data - actuals_new_test_data))

mae_new_test_data
#absolute error 28.83 popularity points (popularity range: 1-100)


