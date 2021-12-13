import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np
import datetime


def rndmDate(start, end):
    time_between_dates = end - start
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start + datetime.timedelta(days=random_number_of_days)
    return random_date


fake = Faker()
select_data = defaultdict(list)

colID = list(pd.read_csv("usuarioColaborador.csv")["colaborador_id"])
cliID = list(pd.read_csv("clientes.csv")["id"])

dL = datetime.date(2020, 1, 1)
dR = datetime.date(2021, 3, 1)

tuples = 100
for _ in range(tuples):
    select_data["id"].append("VE" + "0" * (7 - len(str(_ + 1))) + str(_ + 1))
    select_data["cliente_id"].append(cliID[random.randint(0, len(cliID) - 1)])  # randomClient
    select_data["colaborador_id"].append(colID[random.randint(0, len(colID) - 1)])  # usuarioColaborador
    select_data["fecha"].append(rndmDate(dL, dR))  # coincidir con pelicula o posterior
    select_data["hora"].append(fake.time())
    select_data["qr_id"].append(fake.pystr())

df_select_data = pd.DataFrame(select_data)
df_select_data.to_csv('venta.csv', index=False)
df_select_data.drop_duplicates(keep='first', inplace=True)
display(df_select_data)


# ----------------------------------------------------------------------------


import pandas as pd
from IPython.display import display
from collections import defaultdict
import random

select_data = defaultdict(list)
venta = pd.read_csv("venta.csv")
sede = list(pd.read_csv("sede.csv")["id"])

select_data['id'] = list(venta["id"])
select_data['cliente_id'] = list(venta["cliente_id"])
select_data['colaborador_id'] = list(venta["colaborador_id"])

for i in range(len(sede)):
    select_data["sede_id"].append(sede[random.randint(0, len(sede)-1)])

select_data['fecha'] = list(venta["fecha"])
select_data['hora'] = list(venta["hora"])
select_data['qr_id'] = list(venta["qr_id"])

df_select_data = pd.DataFrame(select_data)
df_select_data.drop_duplicates(keep='first', inplace=True)
df_select_data.to_csv('venta.csv', index=False)
display(df_select_data)