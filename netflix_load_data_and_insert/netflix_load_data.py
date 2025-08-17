import pandas as pd
import mysql.connector
from datetime import datetime

# Load the CSV
df = pd.read_csv("netflix_titles.csv")

# Clean 'date_added' column to proper date format
df['date_added'] = pd.to_datetime(df['date_added'], errors='coerce').dt.date

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Hysoyam",
    database="netflix_project"
)
cursor = conn.cursor()

import pandas as pd
import mysql.connector
from datetime import datetime

# Load the CSV
df = pd.read_csv("netflix_titles.csv")
df["title_id"] = df["title_id"].astype(int)

# Convert empty strings to None
df = df.where(pd.notnull(df), None)

# Connect to MySQL
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Hysoyam",
    database="netflix_project"
)
cursor = cnx.cursor()

# Insert data row by row
for _, row in df.iterrows():
    query = """
    INSERT INTO titles (
        title_id, type, title, director, cast, country,
        date_added, release_year, rating, duration, listed_in, description
    )
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    # Convert date_added to MySQL DATE format if not None
    date_added = None
    if row['date_added']:
        try:
            date_added = datetime.strptime(row['date_added'], "%B %d, %Y").date()
        except:
            date_added = None  # fallback if format fails

    # Ensure release_year is int (MySQL YEAR)
    release_year = int(row['release_year']) if pd.notnull(row['release_year']) else None

    values = (
        row['title_id'],
        row['type'],
        row['title'],
        row['director'],
        row['cast'],
        row['country'],
        date_added,
        release_year,
        row['rating'],
        row['duration'],
        row['listed_in'],
        row['description']
    )

    try:
        cursor.execute(query, values)
    except Exception as e:
        print(f"❌ Error inserting row {row['title_id']}: {e}")

# Commit and close
cnx.commit()
cursor.close()
cnx.close()
print("✅ Data loaded successfully!")