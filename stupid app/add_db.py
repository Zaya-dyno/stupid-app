import sqlite3
import csv
con = sqlite3.connect("chars.sql")

with open("chars.csv",newline='') as f:
    reader = csv.reader(f)
    data = list(reader)

i= 0

con.execute("CREATE TABLE characters(key INT PRIMARY KEY,char string, sound string ,meaning string)")

data = data[1:]

for ent in data:
    ent = ent[1:4]
    con.execute("INSERT INTO characters(key,char,sound,meaning) VALUES(" + str(i) + ",\"" + "\",\"".join(ent) + "\");")
    i += 1
    con.commit()
