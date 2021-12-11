import glob
import pandas as pd
from IPython.display import display
from faker import Faker
import datetime
"""
for file in glob.glob("*.csv"):
    print(file, end=" \t-> ")
    df = pd.read_csv(file)
    print(df.columns.to_list())
    
df = pd.read_csv("clientes.csv")
display(df)

fake = Faker()
d = fake.date_between(start_date='-330d', end_date='today')
print(d)
print(type(d))

e = fake.date_between(start_date=d, end_date=d+datetime.timedelta(days=30))
print(e)
print(type(d))

"""


colaboradores = pd.read_csv("colaboradores.csv")
colaboradores["nro_documento"] = colaboradores["nro_documento"][0:9]
colaboradores.to_csv('colaboradores.csv', index=False)

