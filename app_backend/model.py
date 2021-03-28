import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix
import pickle

# ------------preprocessing-----------------------------------------
df = pd.read_csv('dataset.csv')
cols = [i for i in df.iloc[:, 1:].columns]
tmp = pd.melt(df.reset_index(), id_vars=['index'], value_vars=cols)
tmp['add1'] = 1
diseases = pd.pivot_table(tmp,
                          values='add1',
                          index='index',
                          columns='value')

# Add labels column
diseases.insert(0, 'label', df['Disease'])

diseases = diseases.fillna(0)

# ----splitting the data----------------------------------------------
ds_train = diseases.sample(frac=0.7, random_state=1)
ds_test = diseases.drop(index=ds_train.index)
x_train, y_train, x_test, y_test = ds_train.drop(
    'label', axis=1), ds_train['label'], ds_test.drop('label', axis=1), ds_test['label']


# -----creating the model------------------------------------------------
rfc = RandomForestClassifier()
rfc.fit(x_train, y_train)

# saving the model to disk----------------------------------------------
pickle.dump(rfc, open('model.pkl', 'wb'))
