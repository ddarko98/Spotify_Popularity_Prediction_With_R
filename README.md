This analysis aimed to predict song popularity using a linear regression model based on various audio features and, in this improved version, the song's release year and explicit content status.

Model Setup and Data Preparation:
The spotify_data dataset, containing information on 10,000 songs, was loaded and filtered to include key audio features (Danceability, Energy, Loudness, Tempo, Acousticness, Instrumentalness, Liveness, Speechiness, Valence, Track.Duration..ms.), along with Popularity as the target variable. Crucially, the model was enhanced by extracting Release.Year from Album.Release.Date and including Explicit content status, both of which were transformed into appropriate formats for the linear model. The data was then split into 80% training and 20% testing sets to evaluate the model's performance on unseen data.

Model Performance:
The linear regression model (model_reg) was trained on the prepared data.

R-squared: The Multiple R-squared value for the model was 0.02664 (approximately 2.66%). While this represents an improvement over earlier iterations of the model (which had R-squared values around 1%), it still indicates that only a small percentage of the variance in song popularity can be explained by the current set of features in a linear relationship.

Mean Absolute Error (MAE): The MAE calculated on the test_data (and confirmed on the new_test_data) was approximately 28.84 popularity points. This means that, on average, the model's predictions for a song's popularity deviate from its actual popularity by about 28.84 points on a scale typically ranging from 0 to 100. This suggests that while the model has some predictive capability, its predictions are still quite broad.

Key Predictors:
Based on the summary(model_reg) output, several variables were found to be statistically significant in predicting song popularity:

Release.Year: This emerged as one of the most statistically significant predictors (p < 2e-16), indicating a strong relationship with popularity. The negative coefficient suggests that, on average, older songs in this dataset tend to have slightly higher popularity scores, though the visual plot shows a wide scatter.

Danceability: Also highly significant (p = 1.20e-10), with a positive coefficient, suggesting that more danceable songs tend to be more popular.

Loudness: Highly significant (p = 1.79e-08), with a positive coefficient.

Valence: Highly significant (p = 1.08e-05), with a negative coefficient.

Instrumentalness: Very significant (p = 0.00353), with a negative coefficient, implying that less instrumental (more vocal) songs tend to be more popular.

Explicit: Found to be significant (p = 0.00142), with a positive coefficient for Explicittrue, suggesting explicit songs in this dataset are slightly more popular on average.

Visual Insights:
The ggplot visualizations for Popularity vs Danceability and Popularity vs Release.Year visually reinforce the findings. While a linear trend is visible (e.g., a slight negative slope for Release.Year, a positive slope for Danceability), the wide scatter of data points around the regression line clearly illustrates the substantial unexplained variance, consistent with the low R-squared value.

Conclusion:
The linear regression model successfully identified several statistically significant factors influencing song popularity, with Release.Year and Danceability being among the most prominent. The inclusion of Release.Year and Explicit content status led to a modest improvement in the model's explanatory power and a slight reduction in prediction error (MAE).

However, despite these improvements, the model's overall predictive accuracy remains limited, as evidenced by the relatively low R-squared and high MAE. This suggests that while audio features, release year, and explicit content play a role, song popularity is a complex phenomenon likely influenced by many other uncaptured factors (e.g., artist fame, genre, marketing, cultural trends, social media virality) that a simple linear model with the current feature set cannot fully explain. Further model enhancements would require incorporating such external data or exploring more advanced modeling techniques.
