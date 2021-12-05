import pandas as pd
from IPython.display import display
from faker import Faker
from collections import defaultdict
import random

fake = Faker()
fake_data = defaultdict(list)

i = 1
tuples = 100
for _ in range(tuples):
    fake_data['id'].append("AT" + "0"*(7 - len(str(i))) + str(i))
    fake_data['nombre'].append(fake.job())
    i += 1
df_fake_data = pd.DataFrame(fake_data)
df_fake_data.to_csv('areaTrabajo.csv', index = False)
display(df_fake_data)