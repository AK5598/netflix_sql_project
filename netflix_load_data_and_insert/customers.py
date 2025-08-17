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

genders = ['Male', 'Female', 'Other']

for i in range(1, 100000):
    name = fake.name()
    country = fake.country()
    gender = random.choice(genders)
    age = random.randint(18, 70)
    signup_date = fake.date_between(start_date='-2y', end_date='today')

    cursor.execute("""
        INSERT INTO customers (customer_id, customer_name, country, gender, age, signup_date)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (i, name, country, gender, age, signup_date))

conn.commit()
conn.close()