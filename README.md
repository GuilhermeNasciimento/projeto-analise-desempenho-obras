# Construction Project Performance Analysis

## About the Project

This project presents a data analysis workflow applied to construction project management and performance monitoring.

The objective is to analyze operational data related to productivity, costs, planned versus actual execution, quality, delays, and rework.

The project was developed as part of my Data Analytics portfolio using Python, SQL, and Power BI.

> **Disclaimer:** The dataset is synthetic and was created for educational and portfolio purposes. It does not represent real companies or specific construction projects.

---

## Objectives

Analyze the operational performance of different construction projects, teams, and services to identify patterns related to:

- Productivity
- Costs
- Planned versus actual execution
- Delays
- Quality
- Rework
- Weather conditions

The workflow covers data preparation and analysis through to the development of an interactive Power BI dashboard.

---

## Business Questions

The analysis explores questions such as:

- What is the total cost of the construction projects?
- What quantity of work was completed?
- What percentage of planned work was executed?
- How does productivity change over time?
- How does productivity vary across teams and services?
- Which services have the highest cost per unit?
- Which services have the highest average delays?
- Is there an association between weather conditions and delays?
- Which services account for the largest volume of rework?
- Is there a relationship between quality and rework?

---

## Dataset

The dataset contains records related to service execution across multiple construction projects.

Key fields include:

- Project
- City
- Team
- Service
- Date
- Planned quantity
- Actual quantity
- Working hours
- Actual cost
- Delay in days
- Rework hours
- Quality index
- Weather conditions

The dataset is synthetic and does not contain actual business or construction project records.

---

## Python Analysis

Python was used for:

- Initial data exploration
- Identifying potential data inconsistencies
- Data cleaning and preparation
- Descriptive and statistical analysis
- Productivity and cost analysis
- Team-level and service-level analysis
- Generating summary tables

**Main libraries:** Pandas, NumPy, and Matplotlib.

The complete notebook is available at:

`notebooks/01_analise_obras.ipynb`

---

## SQL Analysis

SQLite was used to run analytical queries on the processed data.

The SQL analysis includes:

- Aggregations by team and service
- Productivity calculations
- Cost per unit
- Delay analysis
- Classification using `CASE WHEN`
- Common Table Expressions (CTEs)
- Window functions
- Team rankings
- Time-based analysis
- Planned versus actual quantity comparisons

Queries are available at:

`sql/queries.sql`

---

## Power BI Dashboard

An interactive Power BI dashboard was developed using a dimensional data model.

### Page 1 — Executive Overview

Presents the main performance indicators:

- Total cost
- Actual quantity completed
- Productivity
- Execution percentage
- Percentage of records with delays
- Productivity trends over time
- Total cost by construction project

![Executive Overview](imagens/visao_executiva.png)

---

### Page 2 — Operational Analysis

Examines performance differences across teams and services.

Key analyses:

- Productivity by team
- Productivity by service
- Cost per unit
- Planned versus actual quantities
- Productivity by team and service

![Operational Analysis](imagens/analise_operacional.png)

---

### Page 3 — Quality and Delays

Examines quality indicators and schedule performance.

Key analyses:

- Average quality
- Average delay
- Percentage of records with delays
- Rework hours
- Delays by service
- Delays by weather condition
- Rework by service
- Quality by team and service

![Quality and Delays](imagens/qualidade_atrasos.png)

---

## Key Findings

The following findings were observed in the synthetic dataset used for this project.

### 1. Planned Execution versus Delays

Actual cumulative execution reached **101.79% of the planned quantity**.

At the same time, **68.50% of records showed some delay**.

This illustrates that achieving the planned volume does not necessarily mean that all activities were completed on schedule.

### 2. Productivity Differences Across Teams

Overall aggregated productivity was approximately **0.94**.

The observed team-level results ranged approximately as follows:

- Team E: **1.24**
- Team C: **1.07**
- Team A: **0.97**
- Team D: **0.84**
- Team B: **0.76**

Comparisons should also account for the types of services performed by each team.

### 3. Productivity and Schedule Performance

The Foundation service showed high productivity while also recording one of the highest average delays, at approximately **3.4 days**.

This highlights why productivity and schedule performance should be analyzed as separate dimensions.

### 4. Weather Conditions and Delays

Records associated with more adverse weather conditions showed higher average delays.

The **Heavy Rain** category had a substantially higher average delay than the **Normal** category.

This is an observed association in the dataset, not evidence of a causal relationship.

### 5. Rework

The dataset contained approximately **17,470 hours of rework**.

The highest rework volumes were observed in **Finishing** and **Painting** services.

A complementary analysis of the rework rate can help compare services with different work volumes.

---

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- SQL
- SQLite
- Power BI
- DAX
- Google Colab

---

## How to Run the Project

### Prerequisites

- Python installed
- Dependencies listed in `requirements.txt`

### 1. Install Dependencies

From the project root directory, run:

```bash
pip install -r requirements.txt
```

### 2. Run the Analysis Script

From the project root directory, run:

```bash
python src/analise_obras.py
```

The results will be saved in `resultados/EDA/`.

### 3. Explore the Notebook

Open `notebooks/01_analise_obras.ipynb` in VS Code or Google Colab.

File paths may need to be adjusted depending on the execution environment.

### 4. Open the Power BI Dashboard

Open `powerbi/Projeto 01.pbix` using Power BI Desktop.

---

## Project Structure

```text
projeto_01_analise_obras/
├── data/
│   ├── raw/
│   │   └── obras_produtividade.csv
│   └── processed/
│       ├── obras_produtividade_tratado.csv
│       └── obras.db
├── notebooks/
│   └── 01_analise_obras.ipynb
├── src/
│   └── analise_obras.py
├── sql/
│   └── queries.sql
├── powerbi/
│   ├── Projeto 01.pbix
│   └── README_POWERBI.md
├── imagens/
│   ├── analise_operacional.png
│   ├── qualidade_atrasos.png
│   └── visao_executiva.png
├── resultados/
│   └── EDA/
├── .gitignore
├── README.md
└── requirements.txt
```

## Project Purpose

This portfolio project demonstrates practical experience with data preparation, exploratory analysis, SQL queries, KPI analysis, and interactive data visualization using Power BI.

The project uses synthetic data for educational purposes and does not claim to represent real-world client results.
