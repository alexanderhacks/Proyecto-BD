
import pandas as pd
from IPython.display import display
from faker import Faker
from collections import defaultdict
import random

fake = Faker()
fake_data = defaultdict(list)

i = 1
tuples = 100		# number of tuples 100 1000 10000 100000 1M
for _ in range(tuples):     # alterar lineas para las diversas columnas de la BD
    fake_data['id'].append("S" + "0"*(8 - len(str(i))) + str(i))
    fake_data['nombre'].append("Cinemania " + fake.street_suffix())
    fake_data['direccion'].append(fake.street_address())
    fake_data['departamento'].append(fake.city())
    fake_data['distrito'].append(fake.street_name())
    fake_data['n_salas'].append(random.sample([30, 50, 70], 1)[0])
    i += 1

df_fake_data = pd.DataFrame(fake_data)
df_fake_data.to_csv('sede.csv', index = False)
display(df_fake_data)