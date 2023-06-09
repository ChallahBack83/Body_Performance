# Body Performance Multi-Class Classification

Checkout our Dashboard [HERE](https://public.tableau.com/app/profile/josh.albrecht/viz/BodyPerformanceDataFinal/BodyPerformanceData).

## Topic Overview

For this project, we have chosen to explore Body Performance and how it may be used to verify and classify the health level of individuals. Health tracking and fitness data have become very popular especially with the rise of wearable fitness trackers and smartphones. According to [Fortune Business Insights](https://www.fortunebusinessinsights.com/fitness-tracker-market-103358), a 2019 Pew Research poll shows 1 in 5 Americans regularly use fitness monitoring devices, and that number is growing. The global market size for fitness trackers as of 2020 was valued at 36.34 billion USD and projected to be worth 114.36 billion USD by 2028. There are even medical professionals running research programs using these wearables to understand, analyze practices, and improve decision making[^1]. This market growth demonstrates the continuing importance of understanding which data points matter for predicting health and quality of life.  These are the reasons we have selected Body Performance as our topic for this final project.

## Project Contents

- Data Cleaning & Exploration [HERE](Data_Cleaning.ipynb).
- Database Schema [HERE](https://github.com/ChallahBack83/Body_Performance/blob/main/queries_for_tables.sql)
- Database Creation image [HERE](https://github.com/ChallahBack83/Body_Performance/blob/main/Table%20Images/body_performance_table.png)
- Database ERD [HERE](https://github.com/ChallahBack83/Body_Performance/blob/main/Table%20Images/ERD%20Schema.png)
- Machine Learning, Final Model [HERE](final_ml_model.ipynb)
- Dashboard [HERE](https://public.tableau.com/app/profile/josh.albrecht/viz/BodyPerformanceDataFinal/BodyPerformanceData)
- Presentation Slide Deck [HERE](https://docs.google.com/presentation/d/1kYg-bvy_dPiT_QFUBEQEtB2kAm_iFrdXltL5T15IgjE/edit#slide=id.p)


## Communication Protocols & Team Breakdown

- Team Breakdown
  - Meredith Rau is managing the README, GitHub, and machine learning.
  - Joshua Albrecht is managing the dashboard, data cleaning, and data exploration.
  - Estefany Lutker is leading database management, queries, and working on analysis.
  - Amani Smith is leading the slide preparation and working on data exploration and visualizations.
- Communication
  - As a team, we will remain in constant contact through our Slack chat, notifying each other when we are working in order to collaborate.
  - Meeting a minimum of 3 times each week, as a whole team or in pairs, to finalize each segment.
  - When we update code or other files in our branches, we will notify the team to review.
  - Update README in main branch before the end of each work session.
  - As a team, we will work through each of these sections together, either in pairs or as a group, and not leave any team member completely alone on their segment of the project.

## Technologies

- Database Tools
  - PostgresSQL through PgAdmin for setting up, querying, and merging the database.
  - Psycopg2 Python library for database connection.
- Data Processing
  - Python
  - Jupyter Notebook
  - Pandas, NumPy, Matplotlib, and SciKitLearn for analysis and processing.
  - Psycopg2 for database connection to PostgresSQL.
- Visualizations
  - Google Slides for presentations slide deck.
  - Tableau for dashboard and story.
  - Plotly for some graphics to be added to dashboard.
  - Graphviz to visualize machine learning tree.
- Machine Learning
  - Jupyter Notebook
  - Python
  - Pandas, NumPy, and SciKitLearn.
  - SciKitLearn for machine learning, preprocessing, and Ensemble testing.
  - Tensorflow for neural network modeling.
 
## Dataset Description
 
Because of privacy regulations, most data sourced by wearables is not open to the public. However, some individuals and research organizations have provided datasets that allow us to study fitness and health datapoints. Our dataset was found on [Kaggle](https://www.kaggle.com/datasets/kukuroo3/body-performance-data) and originally sourced from the Korea Sports Promotion Foundation on the Korean website, [BigData Culture](https://www.bigdata-culture.kr/bigdata/user/data_market/detail.do?id=ace0aea7-5eee-48b9-b616-637365d665c1). The data has gone through some post-processing and filtering, but it still contains 12 features and 13,393 rows of data.  We tried to access the updated raw data, but we could not do so without Korean contact information.

Our working dataset is a CSV containing data (mainly integers and floats) of a subject's physical statistics as well as tracked information from their performance on various activities.  The physical statistics include age, gender, height, weight, body fat, and blood pressure while the tracked activities are gripForce, sit and bed forward, sit-ups, and broad jump. 

![orig_csv](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/Images/orig_csv.png)

## Questions We Hope to Answer

  - Can we accurately classify a person's level of body performance (or health) using physical and activity statistics?
  - What features impact class or body performance the most?
  - How does age factor into given body performance?
  - Is there a dramatic difference between genders?
  - How do some features impact others?
    - Weight or body fat to activity performance?
    - Age to activity performance ?
    

## Data Exploration & Analysis

On initial inspection, our data is fairly clean, with no null values. However, we did need to rename some columns to make them work within SQL since they were words that were functions (id and class) or included symbols that did not work (body_fat_%).

Each subject has been assigned a class (A,B,C,D) based on the data, with A being the best performance and D being the worst. The datapoints are evenly divided among the 4 classes so we do not have a minority class to account for in sampling

![class_count](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/Images/class_cnt.png)

However, breaking down the data, we can see that the gender count is approximately 2-1 male to female, and the age spread is heavily centered on the younger demographics. We will need to take these factors into consideration during our analysis.

![gender_count](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/Gender_breakdown_slides.png)

![age_rank](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/age_rank.png)

The data is easily split into two halves, with half of the features being physical measures and the other half being activity metrics. This is shown in the split of tables in our database which we then joined together with cleaned data. 

Importing the data into visualization tools, we were able to see patterns broken down between the four classes. These lined up clearly with the feature importances discovered in our machine learning models.

![feature_importance_slide](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/feature_importances_slide.png)


## Machine Learning Model

We ran several iterations of machine learning models focusing first on the ensemble learner, RandomForestClassifier. Then we ran several iterations of a NeuralNetwork to compare accuracy and define the best model.  The best accuracy scores of each model are very close with all running close to 74%. Sensitivity for the Balanced Random Forest Classifier is also 75%. 

![model_selection](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/model_selection.png).


Though all the models are close, we are prioritizing the BalancedRandomForestClassifier because of it's speed, with the model running for 12 seconds versus the second best model (Neural Network) at 52 seconds. You can compare models in [this csv](). 

![confusion matrix](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/confusion_matrix.png)


The confusion matrix and classification report show that this model most accurately predicted Rank A (0) and Rank D (3).  This could potentially be influenced by the weight of the number from encoding the target values, but we are not fully sure how should test that yet.

In the neural network, we used OneHotEncode to create binary values in 4 different columns, which did affect the accuracy for the neural network model. However, it did not make the model more accurate than the Ensemble Learners, which were more accurate with Label Encodeing a single Target column with A, B, C, D ranks encoded as 0, 1, 2, 3.

![encode_compare](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/encode_compare.png).

## Database

Final data has been entered into two [tables](https://github.com/ChallahBack83/Body_Performance/blob/main/Table%20Images/importing_data_to_tables.png), one for [physical metrics](https://github.com/ChallahBack83/Body_Performance/blob/main/Resources/Physical_metrics.csv) and another for [activity metrics](https://github.com/ChallahBack83/Body_Performance/blob/main/Resources/Activity_metrics.csv).  They were merged together to create a new [body performance data](https://github.com/ChallahBack83/Body_Performance/blob/main/Resources/body_performance.csv) file for our analysis phase. 

You can view the schema [HERE](https://github.com/ChallahBack83/Body_Performance/blob/main/queries_for_tables.sql) and the updated ERD [HERE](https://github.com/ChallahBack83/Body_Performance/blob/main/Table%20Images/ERD%20Schema.png).
- Created ID based on Index for join/merge.
- Cleaned up data errors.
- Joined into new table.
    

  




[^1]: [Fortune Business Insights 2021 Report using data from 2017-2019](https://www.fortunebusinessinsights.com/fitness-tracker-market-103358).
