# Netflix Content Analysis Project

## 📌 Project Overview
This project delivers an end-to-end data analysis solution focused on exploring and understanding Netflix's global content library. By analyzing dataset features such as titles, genres, release years, production countries, maturity ratings, and cast/crew credits, this project uncovers content distribution patterns, runtime trends, and key localized strategies.

The workflow spans across three major stages:
1. **Data Cleaning & Preprocessing:** Done via **Python (Pandas)** to handle missing values and duplicates.
2. **Advanced Querying:** Structured in **SQL** (MySQL) to parse multi-valued attributes (genres/countries) and aggregate deep business insights.
3. **Data Visualization:** Built into an interactive **Dashboard** to present key performance indicators (KPIs) and distributions dynamically.

---

## 🚀 Key Insights & Findings
* **Peak Content Era:** Content additions peaked significantly in **2019**, showing a heavy strategic push right before the global shift in streaming dynamics.
* **Geographical Dominance:** The **United States** leads content production by a massive margin (2,323+ titles), followed by **India** (622 titles) and Great Britain (404 titles).
* **Target Audience Demographics:** Mature content (**TV-MA**) holds a commanding **15.09% share** of the overall library, marking a distinct focus on adult/young-adult audiences.
* **Format Split:** The dataset highlights a distinct volume difference and behavioral pattern between feature-length Movies and multi-season TV Shows.

---

## 🛠️ Tech Stack & Tools
* **Data Manipulation:** Python `pandas`, `numpy`, `ast`
* **Exploratory Data Analysis (EDA):** Jupyter Notebooks, `matplotlib`, `seaborn`
* **Database Management:** SQL (MySQL) using CTEs, string manipulation, and recursive joins
* **Business Intelligence:** Data Visualization Dashboard (Power BI / Tableau)

---

## 📊 Dataset Structure
The analysis relies on two primary relational datasets:
* **`titles.csv`:** Contains descriptive details of every movie or TV show available (ID, type, title, release year, age certification, runtime, genres, production countries, seasons).
* **`credits.csv`:** Connects titles to their respective cast and crew members (ID, name, character role).

---

## ⚙️ Project Implementation Steps

### 1. Data Cleaning & Preprocessing (Python)
The raw dataset contained nested structures, missing entries, and duplicates. The `data_cleaning.ipynb` notebook handled the following:
* Removed identical record duplicates across both datasets.
* Imputed missing values for categorical metrics (e.g., classifying unrated content as `'Not Rated'` within `age_certification`).
* Prepared clean `.csv` files for seamless relational database ingestion.

### 2. Deep-Dive Analytical Querying (SQL)
The script `sql_analysis.sql` leverages advanced querying techniques to answer key stakeholder questions:
* **Multi-Valued Attribute Parsing:** Utilized a recursive `CTE` (`numbers` table) alongside `SUBSTRING_INDEX` to clean and extract list-formatted columns like `production_countries` and `genres` into individual row records.
* **Data Bucketing:** Standardized movie lengths into continuous runtime buckets (`Under 60 min`, `60-90 min`, `91-120 min`, etc.) to find the most popular viewing lengths.
* **Aggregations:** Evaluated year-over-year production shifts, distribution of TV seasons, top 10 historical directors, and top 10 most featured actors.

### 3. Dashboard Visualization
The clean and aggregated data was translated into visual stories to provide clear tracking metrics. 

#### Dashboard Previews
> *Note: Place your uploaded screenshots inside a folder named `images/` in your repository and update the paths below if necessary.*

##### **Dashboard Page 1: Content Breakdown Overview**
![Content Split & Production Geographies](DPA3_1.png)

##### **Dashboard Page 2: Ratings, Runtimes, and Seasonal Distributions**
![Maturity Ratings & Runtime Analysis](DPA3_2.png)

##### **Dashboard Page 3: Top Creator & Talent Insights**
![Top Directors and Actor Castings](DPA3_3.jpg)

---

## 📂 Repository File Directory
```text
├── dataset/                  # Source data files (titles.csv, credits.csv)
├── images/                   # Dashboard screenshots used in README
├── data_cleaning.ipynb       # Python data cleaning script 
├── sql_analysis.sql          # Advanced SQL queries for metrics extraction
└── README.md                 # Project documentation
