import pandas as pd
import mysql.connector

# CSV file path
csv_path = "C:/Users/arcad/IdeaProjects/SOLAR/weather_data.csv"

# Connect to MySQL
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Cute@ko123',
    database='solar_db'
)
cursor = conn.cursor()

# Read CSV
df = pd.read_csv(csv_path)

# Replace invalid values with None (NULL in MySQL)
df.replace([-1, -99, '-1', '-99', ''], None, inplace=True)

# Add the 'location' column with default value
df['location'] = 'Quezon City'

# Insert each row into the weather table
for _, row in df.iterrows():
    cursor.execute("""
                   INSERT INTO weather (year, month, day, rainfall, tmax, tmin, rh, wind_speed, wind_direction, location)
                   VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                   """, (
                       row['YEAR'], row['MONTH'], row['DAY'],
                       row['RAINFALL'], row['TMAX'], row['TMIN'],
                       row['RH'], row['WIND_SPEED'], row['WIND_DIRECTION'],
                       row['location']
                   ))

# Commit and close
conn.commit()
cursor.close()
conn.close()

print("✅ Weather data inserted successfully with location set to 'Quezon City'!")
