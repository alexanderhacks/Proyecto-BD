
import pandas as pd
from IPython.display import display
from faker import Faker
from collections import defaultdict
import random

fake = Faker()
fake_data = defaultdict(list)

i = 1
tuples = 100		# number of tuples 100 1000 10000 100000 1M
email_domain = ["@example.org", "@gmail.com", "@outlook.com", "@hotmail.com"]
for _ in range(tuples):     # alterar lineas para las diversas columnas de la BD
    fake_data['id'].append("C" + "0"*(8 - len(str(i))) + str(i))

    name = fake.first_name(); lastname = fake.last_name()
    fake_data['nombres'].append(name)
    fake_data['apellidos'].append(lastname)
    fake_data['correo'].append((name.lower() + "_" + lastname.lower() + email_domain[random.randint(0, 3)])[0:49])
    fake_data['celular'].append(fake.msisdn()[0:8])
    i += 1

df_fake_data = pd.DataFrame(fake_data)
df_fake_data.drop_duplicates(keep='first', inplace=True)
df_fake_data.to_csv('clientes.csv', index=False)
display(df_fake_data)