
import pandas as pd
from IPython.display import display
from faker import Faker
from collections import defaultdict
import random
import numpy as np
import string

#foods = list(pd.read_csv("foods.txt"))
with open('foods.txt', 'r') as f:
    foods = [line.strip() for line in f]
#display(foods)
#print(len(foods))

fake_data = defaultdict(list)
idx_list = list(np.random.permutation(np.arange(0,410))[:410])
tuples = 100
idx = 1
letters = string.ascii_lowercase
for _ in range(tuples):
    fake_data['id'].append("PR" + "0"*(7 - len(str(idx))) + str(idx))
    fake_data['nombre'].append(foods[idx_list[idx-1]])
    fake_data['descripcion'].append(''.join(random.choice(letters) for i in range(20)))
    fake_data['precio_venta'].append(random.randint(10, 50))
    idx += 1

df_fake_data = pd.DataFrame(fake_data)
df_fake_data.drop_duplicates(keep='first', inplace=True)
df_fake_data.to_csv('productos.csv', index = False)
display(df_fake_data)