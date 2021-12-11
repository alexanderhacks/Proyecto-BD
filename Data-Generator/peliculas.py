import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np
import datetime

fake = Faker()
select_data = defaultdict(list)

peliculas = [l[:-1] for l in np.unique(np.array(open("peliculas.txt", "r", encoding='utf8').readlines()))]
print(peliculas)

tuples = min(100, len(peliculas))
idx_list = list(np.random.permutation(np.arange(1,tuples+1))[:tuples])
dir = list(pd.read_csv("directores.csv")["id"])
gen = list(pd.read_csv("genero.csv")["id"])
nivel = list(pd.read_csv("nivelPublico.csv")["id"])
duracion = [1, 2, 1.5, 1.75]

for i in range(tuples):
    select_data['id'].append("MOV" + "0" * (6 - len(str(i + 1))) + str(i + 1))
    select_data['nombre'].append(peliculas[i])
    select_data['idioma'].append(fake.bank_country())

    adq = fake.date_between(start_date='-340d', end_date='today')
    emi = fake.date_between(start_date=adq, end_date=adq+datetime.timedelta(days=30))
    select_data['fecha_adquisicion'].append(adq)
    select_data['fecha_estreno'].append(emi)

    select_data['genero_id'].append(gen[random.randint(0, len(gen) - 1)])
    select_data['duracion_h'].append(duracion[random.randint(0, len(duracion) - 1)])
    select_data['resena'].append(fake.paragraph(nb_sentences=1)[:99])
    select_data['nivelpublico_id'].append(nivel[random.randint(0, len(nivel) - 1)])
    select_data['id_directores'].append(dir[random.randint(0, len(dir) - 1)])

df_select_data = pd.DataFrame(select_data)
df_select_data.drop_duplicates(keep='first', inplace=True)
df_select_data.to_csv('peliculas.csv', index=False)
display(df_select_data)



