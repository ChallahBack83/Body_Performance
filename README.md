# GroupProject2023


## Presentation & Project Draft

### Project Topic

For this project, we have chosen to explore Body Performance and how it may be used to verify and classify the health level of individuals. Health tracking and fitness data have become very popular especially with the rise of wearable fitness trackers and smartphones. According to [Fortune Business Insights](https://www.fortunebusinessinsights.com/fitness-tracker-market-103358), a 2019 Pew Research poll shows 1 in 5 Americans regularly use fitness monitoring devices, and that number is growing. The global market size for fitness trackers as of 2020 was valued at 36.34 billion USD and projected to be worth 114.36 billion USD by 2028. There are even medical professionals running research programs using these wearables to understand, analyze practices, and improve decision making[^1]. This market growth demonstrates the continuing importance of understanding which data points matter for predicting health and quality of life.  These are the reasons we have selected Body Performance as our topic for this final project.
 
### Dataset Description
 
Because of privacy regulations, most data sourced by wearables is not open to the public. However, some individuals and research organizations have provided datasets that allow us to study fitness and health datapoints. Our dataset was found on [Kaggle](https://www.kaggle.com/datasets/kukuroo3/body-performance-data) and originally sourced from the Korea Sports Promotion Foundation on the Korean website, [BigData Culture](https://www.bigdata-culture.kr/bigdata/user/data_market/detail.do?id=ace0aea7-5eee-48b9-b616-637365d665c1). The data has gone through some post-processing and filtering, but it still contains 12 features and 13,393 rows of data.  We tried to access the updated raw data, but we could not do so without Korean contact information.

Our working dataset is a CSV containing data (mainly integers and floats) of a subject's physical statistics as well as tracked information from their performance on various activities.  The physical statistics include age, gender, height, weight, body fat, and blood pressure while the tracked activities are gripForce, sit and bed forward, sit-ups, and broad jump. 

![orig_csv](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/Images/orig_csv.png)

Each subject has also been assigned a class (A,B,C,D) based on the data, with A being the best performance and D being the worst. The datapoints are evenly divided among the 4 classes. 

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

### Questions We Hope to Answer

  - Can we accurately classify a person's level of body performance (or health) using physical and activity statistics?
  - What features impact class or body performance the most?
  - How does age factor into given body performance?
  - Is there a dramatic difference between genders?
  - How do some features impact others?
    - Weight or body fat to blood pressure?
    - Weight or body fat to sit/bends, gripForce, situps, broad jump?
    - Age to activity level?
    - Gender to activity level?
    
## Communication Protocols & Team Breakdown

- Communication
  - As a team, we will remain in constant contact through our Slack chat, notifying each other when we are working in order to collaborate.
  - Meeting a minimum of 2-3 times each week, as a whole team or in pairs, to finalize each segment.
  - When we update code or other files in our branches, we will notify the team to review.
  - Update README in main branch before the end of each work session.

- Team Breakdown
  - Meredith is managing the README and oversight on the GitHub repository.
  - Joshua is taking point on data cleaning, processing, and coding.
  - Estefany is leading the database set up, queries, and management.
  - Meredith is taking point on the machine learning model.
  - Amani is leading the slide preparation and dashboard set up through Tableau

As a team, we will work through each of these sections together, either in pairs or as a group, and not leave any team member completely alone on their segment of the project.

## Technologies

- Python, Pandas, Numpy in Juptyer Notebook for coding, processing, analysis, and preparing and running machine learning model.
  - May want to consider Google Collab for access to TensorFlow/AWS connection.
- SciKitLearn for machine learning model using Ensemble testing 
  - With size of dataset, may be best to use TensorFlow and Keras
- PgAdmin/Postgres for setting up, querying, and merging the database.
- Plotly, and Tableau for visualizations and dashboard creation.
- SQLITE for database.
- Google Slides for building presentation slide deck.

## Machine Learning Model

- See [v1.1.ipynb_file](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/body_perf_ml_v1.1.ipynb) which shows first test of model using Random Forest.
- [x] Takes in data from provisional database
   - Was pulling this from PDF Rubric.
   - Built connection to PostGres successfully see [HERE](https://github.com/ChallahBack83/Body_Performance/blob/M_Rau/bodyperf_ml_v1.2.ipynb) for version 1.2 with connection code.
- [x] Outputs label(s) for input data
  - Classification
  - Neural network

## Database

- Initial data entered into final database
  - Table 1: Physical Features
  - Table 2: Activity Features
  - See E_Lutker branch for images.
- Created ID based on Index for join/merge.
- Found data errors we will clean up and rerun through Database.
- Joined into new table.

Screenshot of final merged table from separate 2 tables:

![table_3](https://github.com/ChallahBack83/Body_Performance/blob/E_Lutker/table_3_test.png)

## Working Checklist for Project

### Presentation

#### Segment 2
- [x] Description of Data exploration phase of the project.
 - Less Text
- [ ] Description of Analysis phase of the project.
  - Include images in these sections. Should show results of preliminary analysis.
- [x] Technologies, languages, tools, algorithims used.
  - Tighten and update this list.

-- *Only on PDF Rubric from course GitLab Pull* --
#### Dashboard  
- [ ] Draft presentation on Google Slides  
- [ ] Storyboard of Dashboard on Google Slides
  - [ ] Description of tools for final dashboard
  - [ ] Description of interactive elements

### GitHub

-- *Only on PDF Rubric from course GitLab Pull* --
#### Segment 2   
- [ ] production ready code in the Main Branch
  - all code for exploratory analysis
  - some code for machine learning
- [ ] Branch for each with total of 8 commits each (minimum)
- [ ] README.md
  - [x] Communication protocols
  - [ ] Outline of project with images (see Presentation above)

### Machine Learning Model

#### Segment 2
- [ ] Machine learning model finished if not complete
- [ ] Confusion matrix & accuracy score.
  - [ ] Interpretation of accuracy, precision, sensitivity

-- *Only on PDF Rubric from course GitLab Pull* --
- [ ] Description of model  
  - [ ] Discussion of preprocessing
  - [ ] Description preliminary feature engineering, selection, & decision making process
  - [ ] Description of how data was split train/test
  - [ ] Explanation of model choice
    - limitations & benefits
    - Document problems and share instead of focusing on solving all little problems.


### Database

#### Segment 2
- [x] Database stores data for the project with at least 2 tables
- [x] Integretes with machine learning model

-- *Only on PDF Rubric from course GitLab Pull* --
- [x] Includes at least one join using DB language not Pandas
- [x] At least one connection string (SQLAlchemy)

[^1]: [Fortune Business Insights 2021 Report using data from 2017-2019](https://www.fortunebusinessinsights.com/fitness-tracker-market-103358).
