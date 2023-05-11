# GroupProject2023

Rough draft of presentation slide [HERE](https://docs.google.com/presentation/d/1kYg-bvy_dPiT_QFUBEQEtB2kAm_iFrdXltL5T15IgjE/edit#slide=id.p).

## Presentation & Project Draft

### Project Topic

For this project, we have chosen to explore Body Performance and how it may be used to verify and classify the health level of individuals. Health tracking and fitness data have become very popular especially with the rise of wearable fitness trackers and smartphones. According to [Fortune Business Insights](https://www.fortunebusinessinsights.com/fitness-tracker-market-103358), a 2019 Pew Research poll shows 1 in 5 Americans regularly use fitness monitoring devices, and that number is growing. The global market size for fitness trackers as of 2020 was valued at 36.34 billion USD and projected to be worth 114.36 billion USD by 2028. There are even medical professionals running research programs using these wearables to understand, analyze practices, and improve decision making[^1]. This market growth demonstrates the continuing importance of understanding which data points matter for predicting health and quality of life.  These are the reasons we have selected Body Performance as our topic for this final project.
 
### Dataset Description
 
Because of privacy regulations, most data sourced by wearables is not open to the public. However, some individuals and research organizations have provided datasets that allow us to study fitness and health datapoints. Our dataset was found on [Kaggle](https://www.kaggle.com/datasets/kukuroo3/body-performance-data) and originally sourced from the Korea Sports Promotion Foundation on the Korean website, [BigData Culture](https://www.bigdata-culture.kr/bigdata/user/data_market/detail.do?id=ace0aea7-5eee-48b9-b616-637365d665c1). The data has gone through some post-processing and filtering, but it still contains 12 features and 13,393 rows of data.  We tried to access the updated raw data, but we could not do so without Korean contact information.

Our working dataset is a CSV containing data (mainly integers and floats) of a subject's physical statistics as well as tracked information from their performance on various activities.  The physical statistics include age, gender, height, weight, body fat, and blood pressure while the tracked activities are gripForce, sit and bed forward, sit-ups, and broad jump. 

![orig_csv](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/Images/orig_csv.png)

### Questions We Hope to Answer

  - Can we accurately classify a person's level of body performance (or health) using physical and activity statistics?
  - What features impact class or body performance the most?
  - How does age factor into given body performance?
  - Is there a dramatic difference between genders?
  - How do some features impact others?
    - Weight or body fat to sit/bends, gripForce, situps, broad jump?
    - Age to activity level?
    - Gender to activity level?

### Data Exploration & Analysis

On initial inspection, our data is fairly clean, with no null values. However, we did need to rename some columns to make them work within SQL since they were words that were functions (id and class) or included symbols that did not work (body_fat_%).

Each subject has been assigned a class (A,B,C,D) based on the data, with A being the best performance and D being the worst. The datapoints are evenly divided among the 4 classes so we do not have a minority class to account for in sampling

![class_count](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/Images/class_cnt.png)

However, breaking down the data, we can see that the gender count is approximately 2-1 male to female, and the age spread is heavily centered on the younger demographics. We will need to take these factors into consideration during our analysis.
 
```
gender_count = body_df.value_counts("gender")
gender_count

gender
M    8467
F    4926
dtype: int64

age_count = body_df.value_counts("age")
age_df = pd.DataFrame(age_count)
age_df = age_df.reset_index()
age_df.columns = ["age", "counts"]
age_df.head(10)
```

![age_cnt](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/Images/age_cnt.png)

The data is easily split into two halves, with half of the features being physical measures and the other half being activity metrics. This is shown in the split of tables in our database which we then joined together with cleaned data. Find images of our tables [HERE](https://github.com/ChallahBack83/Body_Performance/tree/main/Table%20Images).

Importing the data into visualization tools, we were able to see patterns broken down between the four classes. These lined up clearly with the feature importances discovered in our [machine learning models](https://github.com/ChallahBack83/Body_Performance/tree/main/ml_versions).

![feature_importance](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/rf_feature_list.png)

![dashboard](https://github.com/ChallahBack83/Body_Performance/blob/J_Albrecht/First_Dashboard.png)

## Machine Learning Model

We ran several iterations of machine learning models focusing first on the ensemble learner, [RandomForestClassifier](https://github.com/ChallahBack83/Body_Performance/blob/main/ml_versions/Final_bodyperf_ml_model.ipynb). Then ran several iterations of a [NeuralNetwork](https://github.com/ChallahBack83/Body_Performance/blob/main/ml_versions/NN_final_model.ipynb) to compare accuracy and define the best model.  The best accuracy scores of each model are very close with both running close to 74%. Sensitivity for the RandomForestClassifier is also 75%. We are prioritizing the RandomForestClassifier at the  moment based of the sensitivity score, but we will test speed differences and use that to help select the final model choice.

![confusion matrix](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/rf_confusion_matrix.png)
![rf_classification](https://github.com/ChallahBack83/Body_Performance/blob/main/Images/rf_classification.png)

The confusion matrix and classification report show that this model most accurately predicted Rank A (0) and Rank D (3).  This could potentially be influenced by the weight of the number from encoding the target values, but we are not fully sure how should test that yet.

In the neural network, we used OneHotEncode to create binary values in 4 different columns, which did affect the accuracy for the neural network model. However, it did not make the model more accurate than the RandomForestClassifier which used a single Target column with A, B, C, D ranks encoded as 0, 1, 2, 3.

## Database

Final data has been entered into two [tables](https://github.com/ChallahBack83/Body_Performance/blob/main/Table%20Images/importing_data_to_tables.png), one for [physical metrics](https://github.com/ChallahBack83/Body_Performance/blob/main/Resources/Physical_metrics.csv) and another for [activity metrics](https://github.com/ChallahBack83/Body_Performance/blob/main/Resources/Activity_metrics.csv).  They were merged together to create a new [body performance data](https://github.com/ChallahBack83/Body_Performance/blob/main/Resources/body_performance.csv) file for our analysis phase. 

![body_table](https://github.com/ChallahBack83/Body_Performance/blob/main/Table%20Images/body_performance_table.png)

You can view the schema [HERE](https://github.com/ChallahBack83/Body_Performance/blob/main/Resources/body_perf_schema.sql) and the updated ERD [HERE](https://github.com/ChallahBack83/Body_Performance/blob/main/Table%20Images/ERD_Schema_for_tables.png).
- Created ID based on Index for join/merge.
- Cleaned up data errors.
- Joined into new table.
    
## Communication Protocols & Team Breakdown

- Communication
  - As a team, we will remain in constant contact through our Slack chat, notifying each other when we are working in order to collaborate.
  - Meeting a minimum of 2-3 times each week, as a whole team or in pairs, to finalize each segment.
  - When we update code or other files in our branches, we will notify the team to review.
  - Update README in main branch before the end of each work session.

- Team Breakdown
  - Meredith is managing the README and oversight on the GitHub repository.
  - Joshua is taking point on data cleaning, processing, and visualizations in Tableau
  - Estefany is leading the database set up, queries, and management.
  - Meredith is taking point on the machine learning model.
  - Amani is leading the slide preparation and dashboard set up through Tableau

As a team, we will work through each of these sections together, either in pairs or as a group, and not leave any team member completely alone on their segment of the project.

## Technologies

- Database
  - Postgres through PgAdmin for setting up, querying, and merging the database.
  - Psycopg2 Python library for database connection.
- Visualizations
  - Google Slides for presentations slide deck.
  - Tableau for dashboard and story.
  - Plotly for some graphics to be added to dashboard
- Analysis, Machine Learning, and Data Processing
  - Jupyter Notebook for all coding.
  - Python, with Pandas, Numpy  for processing and analysis
  - SciKitLearn for machine learning, preprocessing, and Ensemble testing.
  - Tensorflow for neural network modeling.
  



## Working Checklist for Project

### Presentation

#### Segment 2
- [x] Description of Data exploration phase of the project.
 - Less Text
- [x] Description of Analysis phase of the project.
  - Include images in these sections. Should show results of preliminary analysis.
- [x] Technologies, languages, tools, algorithims used.
  - Tighten and update this list.

-- *Only on PDF Rubric from course GitLab Pull* --
#### Dashboard  
- [x] Draft presentation on Google Slides  
- [x] Storyboard of Dashboard on Google Slides
  - [ ] Description of tools for final dashboard
  - [ ] Description of interactive elements

### GitHub

-- *Only on PDF Rubric from course GitLab Pull* --
#### Segment 2   
- [ ] production ready code in the Main Branch
  - all code for exploratory analysis
  - some code for machine learning
- [x] Branch for each with total of 8 commits each (minimum)
- [x] README.md
  - [x] Communication protocols
  - [x] Outline of project with images (see Presentation above)

### Machine Learning Model

#### Segment 2
- [x] Machine learning model finished if not complete
- [x] Confusion matrix & accuracy score.
  - [x] Interpretation of accuracy, precision, sensitivity

-- *Only on PDF Rubric from course GitLab Pull* --
- [x] Description of model  
  - [x] Discussion of preprocessing
  - [ ] Description preliminary feature engineering, selection, & decision making process
  - [ ] Description of how data was split train/test
  - [x] Explanation of model choice
    - limitations & benefits
    - Document problems and share instead of focusing on solving all little problems.



[^1]: [Fortune Business Insights 2021 Report using data from 2017-2019](https://www.fortunebusinessinsights.com/fitness-tracker-market-103358).
