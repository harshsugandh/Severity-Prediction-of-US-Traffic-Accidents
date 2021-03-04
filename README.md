# Analysis-of-a-Countrywide-Traffic-Accident-Dataset

This is a countrywide traffic accident dataset, which covers 49 states of the United States. The data is collected from February 2016 to March 2019, using several data providers, including two APIs which provide streaming traffic event data. These APIs broadcast traffic events captured by a variety of entities, such as the US and state departments of transportation, law enforcement agencies, traffic cameras, and traffic sensors within the road-networks. Currently, there are about 2.25 million accident records in this dataset.

Dataset Source: https://smoosavi.org/datasets/us_accidents 


## Objectives
--Real-time accident prediction
--Studying accident hotspot locations
--Casualty analysis
--Studying the impact of precipitation or other environmental stimuli on accident occurrence (cause and effect relationship) 

Environmental stimuli - Visibility(mi), Weather_Condition, Temperature(F), Precipitation(in), etc.


## Uncertainties
Being dependent on a wide range of data attributes which may not be available for all regions (e.g., satellite imagery, traffic volume, and properties of road-network).
Removing cases duplicated along the two sources (Bing and MapQuest may give data about the same accidents)


## Techniques
--Logistic Regression to build a model for performing accident prediction.
--Naïve bayes for classification.
--Ggplots for visualizations.


## Final Outcomes/Predictions
--Traffic accidents are a major public safety issue, so by analyzing the impact of environmental stimuli (e.g., road-network properties, weather, and traffic) on traffic accident occurrence patterns, we can do real-time accident predictions.
--To predict the frequency of accidents within a geographical region.
--To predict risk of accidents.

