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

devices = ['Mobile', 'Tablet', 'Smart TV', 'Laptop', 'Desktop']

watch_id = 1
for _ in range(1000000):  # 1000000 rows
    customer_id = random.choice(customer_ids)
    title_id = random.choice(title_ids)
    watch_date = fake.date_between(start_date='-1y', end_date='today')
    device = random.choice(devices)

    cursor.execute("""
        INSERT INTO watch_history (watch_id, customer_id, title_id, watch_date, device_used)
        VALUES (%s, %s, %s, %s, %s)
    """, (watch_id, customer_id, title_id, watch_date, device))
    watch_id += 1

conn.commit()
conn.close()