from configparser import ConfigParser
import psycopg2
import pandas as pd
from IPython.display import display
from faker import Faker
from collections import defaultdict
import random

# Connection
def get_config(filename='properties.ini', section='postgresql'):
    parser = ConfigParser()         
    parser.read(filename)           

    db_config = {}
    if parser.has_section(section):
        params = parser.items(section)  
        for p in params:
            db_config[p[0]] = p[1]
    else:
        raise Exception('Section {0} not found'.format(section))
    return db_config

def get_connection():
    db_config = get_config()    
    db = psycopg2.connect(**db_config)  # db_connection 
    db.autocommit = True
    cur = db.cursor()       
    return db, cur

# PSQL interactions
def generate_table(tableName="", csvPath=""):
    db, cur = get_connection()
    print(tableName)
    querie = "COPY {0} FROM '{1}' DELIMITER ',' CSV HEADER;".format(tableName, csvPath)
    print(querie)
    cur.execute(querie)

def create_table(tableName, dataDict):
    db, cur = get_connection()
    attDom = [(k + " " + v[0]) for k, v in dataDict.items()]
    lq = ', '.join(map(str, attDom))
    querie = "CREATE TABLE " + tableName + "(" + lq + ");"
    print(querie)
    cur.execute(querie)

# Random Data Generator
def RndmDataGen(tableName, dataDict, tuples = 1000):
    fake = Faker()
    fake_data = defaultdict(list)
    dKeys = [k for k in dataDict.keys()]
    i = 0
    for _ in range(tuples):     # alterar lineas para las diversas columnas de la BD
        fake_data[dKeys[0]].append(i)
        fake_data[dKeys[1]].append(fake.first_name())
        fake_data[dKeys[2]].append(fake.last_name())
        fake_data[dKeys[3]].append(fake.email())
        fake_data[dKeys[4]].append(fake.msisdn()[0:8])
        i += 1

    df_fake_data = pd.DataFrame(fake_data)
    display(df_fake_data)
    df_fake_data.to_csv('fake_data.csv', index = False)

def displayCSV(csvPath):
    df = pd.read_csv(csvPath)
    display(df)

if __name__ == '__main__':
    tName = 'Clientes'
    dDict = {'id': ('VARCHAR(8)', None),          # colName : (domain, csvPath -> PK, FK)
             'nombres': ('VARCHAR(20)', None),
             'apellidos': ('VARCHAR(20)', None),
             'correo': ('VARCHAR(40)', None),
             'celular': ('VARCHAR(9)', None)
             }
    create_table(tableName = tName, dataDict = dDict)
    RndmDataGen(tableName = tName, dataDict = dDict)
    generate_table(tableName = tName, csvPath = "C:/.../fake_data.csv")


""" USEFUL LINKS
https://towardsdatascience.com/python-and-postgresql-how-to-access-a-postgresql-database-like-a-data-scientist-b5a9c5a0ea43
https://zetcode.com/python/faker/
https://faker.readthedocs.io/en/master/providers.html
https://www.analyticsvidhya.com/blog/2021/09/how-to-create-dummy-data-in-python-using-faker-package/
https://hackernoon.com/how-to-create-dummy-data-in-python-lpn37x1
https://kb.objectrocket.com/postgresql/generate-postgres-test-data-with-python-part-2-1253

https://www.a2hosting.com/kb/developer-corner/postgresql/determining-the-size-of-postgresql-databases-and-tables
SELECT pg_size_pretty( pg_total_relation_size('tablename') );

SELECT * FROM clientes;
ALTER TABLE Clientes
	ADD CONSTRAINT id_pk PRIMARY KEY(id);
"""