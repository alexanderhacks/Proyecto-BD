
import pandas as pd
from faker import Faker
from IPython.display import display
from collections import defaultdict
import random
import numpy as np

clientes_l = list(pd.read_csv("clientes.csv")['id'])
n = len(clientes_l)

fake = Faker()
select_data = defaultdict(list)
tuples = random.randint(int(n/10), n-1)
idx_list = list(np.random.permutation(np.arange(0,n-1))[:tuples])
#print(idx_list)

for i in idx_list:     # alterar lineas para las diversas columnas de la BD
    select_data['cliente_id'].append(clientes_l[i+1])
    select_data['nro_certificado'].append("CV" + "0"*(7 - len(str(i+1))) + str(i+1))


df_select_data = pd.DataFrame(select_data)
df_select_data.drop_duplicates(keep='first', inplace=True)
df_select_data.to_csv('clientesVacunados.csv', index=False)
display(df_select_data)
