import sqlite3
import csv
con = sqlite3.connect("test.sql")

with open("hsk1.csv",newline='') as f:
    reader = csv.reader(f)
    data = list(reader)

i = 0
for ent in data:
    con.execute("INSERT INTO characters(key,char,sound,meaning) VALUES(" + str(i) + ",\"" + "\",\"".join(ent) + "\");")
    i += 1
    con.commit()
