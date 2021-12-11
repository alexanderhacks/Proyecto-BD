import pandas as pd
from IPython.display import display
from faker import Faker
from collections import defaultdict
import random
import numpy as np

fake = Faker()
fake_data = defaultdict(list)
idx_list = list(np.random.permutation(np.arange(1,101))[:100])
tipos_cuenta = ["corriente", "chequera", "ahorro", "nomina", "dolares"]

tuples = 100
for _ in range(tuples):
    fake_data['numero_cuenta'].append(fake.iban()[:20])
    numb = str(idx_list[_])
    fake_data['cliente_id'].append("C" + "0"*(8 - len(numb)) + numb)
    fake_data['tipo_cuenta'].append(tipos_cuenta[random.randint(0, 4)])

df_fake_data = pd.DataFrame(fake_data)
df_fake_data.drop_duplicates(keep='first', inplace=True)
df_fake_data.to_csv('cuentaBancaria.csv', index = False)
display(df_fake_data)
