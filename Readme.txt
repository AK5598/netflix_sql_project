# 📊 Netflix SQL Data Analysis Project

This is a full end-to-end data analysis project using SQL, where I analyze Netflix-like user behavior and content performance. I created the database structure, generated synthetic data, and wrote advanced SQL queries to answer business questions.

---

## 🚀 Project Highlights

- Created 6 connected tables (titles, genres, customers, watch history, ratings, etc.)
- Used SQL to perform complex analysis using JOINs, CTEs, CASE, and window functions
- Generated insights helpful for business decisions in a streaming platform

---

## 📁 Project Structure

- data/netflix_titles.csv → Title data from Kaggle (cleaned and used for the titles table)
- scripts/ → Python scripts to load synthetic data using Faker into MySQL
- sql/create_tables.sql → All table creation queries
- sql/analysis_queries.sql → 6 business-focused analysis queries using advanced SQL
- README.md → This file

---

## 🗃️ Tables in the Database

- *titles*: Netflix show metadata  
- *genres*: Genre list  
- *title_genres*: Mapping between titles and genres  
- *customers*: Simulated customers with country, age, gender  
- *watch_history*: What titles users watched and when  
- *ratings*: Ratings given by users to titles

---

## 🔍 Business Questions Answered

1. What are the top 3 most popular genres overall?
2. Who are the top 5 customers who watched the most content?
3. Which titles have the highest average ratings?
4. How does genre preference vary across age groups?
5. What is the average time gap between each customer's viewing sessions?
6. What are the top 3 most watched titles in each country?

These questions use advanced SQL techniques like:
- Window functions (ROW_NUMBER, LAG)
- Common Table Expressions (CTEs)
- Aggregations and filtering
- Subqueries and CASE statements

---

## 🛠 Tools Used

- *MySQL* for SQL queries and database
- *Python (Faker + MySQL connector)* for synthetic data loading
- *Kaggle* for Netflix title data
- *Excel* for quick data formatting

---

## 📌 Dataset Reference

- Netflix Titles Dataset: [Kaggle - Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows)





