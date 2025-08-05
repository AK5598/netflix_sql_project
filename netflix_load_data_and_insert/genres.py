import mysql.connector

genres = [
    'Drama', 'Comedy', 'Action', 'Romance', 'Thriller', 'Horror',
    'Documentary', 'Sci-Fi', 'Adventure', 'Crime', 'Fantasy'
]

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Hysoyam",
    database="netflix_project"
)
cursor = conn.cursor()

for i, genre in enumerate(genres, start=1):
    cursor.execute("INSERT INTO genres (genre_id, genre_name) VALUES (%s, %s)", (i, genre))

conn.commit()
conn.close()