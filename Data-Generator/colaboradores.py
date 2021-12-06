
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
tipo_doc = ['DNI', 'Passport']
puestoTrabajo_t = list(pd.read_csv("puestoTrabajo.csv")['id'])
#print(puestoTrabajo_t)


for _ in range(tuples):     # alterar lineas para las diversas columnas de la BD
    fake_data['id'].append("CL" + "0"*(7 - len(str(i))) + str(i))
    fake_data['nro_documento'].append(fake.ssn())
    fake_data['tipo_documento'].append(tipo_doc[random.randint(0, 1)])
    name = fake.first_name(); lastname = fake.last_name()
    fake_data['nombres'].append(name)
    fake_data['apellidos'].append(lastname)
    fake_data['celular'].append(fake.msisdn()[0:8])
    fake_data['correo'].append(name.lower() + "_" + lastname.lower() + email_domain[random.randint(0, 3)])
    fake_data['cuenta_colaborador'].append(fake.iban()[:20])
    fake_data['areatrabajo_id'].append(puestoTrabajo_t[random.randint(0, len(puestoTrabajo_t))])

    i += 1

df_fake_data = pd.DataFrame(fake_data)
df_fake_data.to_csv('colaboradores.csv', index = False)
display(df_fake_data)
