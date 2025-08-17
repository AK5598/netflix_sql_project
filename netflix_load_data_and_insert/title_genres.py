import random
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Hysoyam",
    database="netflix_project"
)
cursor = conn.cursor()

# Get all title_ids from titles table
cursor.execute("SELECT title_id FROM titles")
title_ids = [row[0] for row in cursor.fetchall()]
genre_ids = list(range(1, 12))  # 1 to 11 for our genres

for title_id in title_ids:
    assigned = random.sample(genre_ids, k=random.randint(1, 3))
    for genre_id in assigned:
        cursor.execute("INSERT INTO title_genres (title_id, genre_id) VALUES (%s, %s)", (title_id, genre_id))

conn.commit()
conn.close()