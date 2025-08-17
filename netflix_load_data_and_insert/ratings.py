from faker import Faker
import random
import mysql.connector

fake = Faker()

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Hysoyam",
    database="netflix_project"
)
cursor = conn.cursor()

cursor.execute("SELECT customer_id FROM customers")
customer_ids = [row[0] for row in cursor.fetchall()]

cursor.execute("SELECT title_id FROM titles")
title_ids = [row[0] for row in cursor.fetchall()]

rating_id = 1
for _ in range(1000000):  # 1000000 rows
    customer_id = random.choice(customer_ids)
    title_id = random.choice(title_ids)
    rating = random.randint(1, 5)
    rating_date = fake.date_between(start_date='-1y', end_date='today')

    cursor.execute("""
        INSERT INTO ratings (rating_id, customer_id, title_id, rating, rating_date)
        VALUES (%s, %s, %s, %s, %s)
    """, (rating_id, customer_id, title_id, rating, rating_date))
    rating_id += 1

conn.commit()
conn.close()