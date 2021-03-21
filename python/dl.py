# $Id$

import pandas as pd
import numpy as np

df = pd.read_csv('data/p.csv')
count_df = df[['d','l','k']].groupby(['d','l']).count().reset_index(drop=False)
#
z = np.zeros([19,14], dtype=np.int)
for d,l,k in zip(count_df['d'], count_df['l'], count_df['k']):
    z[d-1,l-1] = k
#
print(' \\', end='')
for j in range(14):
    print('|', end='')
    print('%4d' % (j+1), end='')
print()
#
print('-' * 2,end='')
for j in range(14):
    print('+', end='')
    print('-' * 4, end='')
print()
#
for i in range(19):
    print('%2d' % (i+1), end='')
    for j  in range(14):
        print('|', end='')
        k = z[i,j]
        if k == 0 and i > 0:
            if z[i-1,j] > 10:
                k = 10**5
                z[i,j] = 10**5
        print('*'*4 if k==10**5 else ('%4d' % z[i,j]), end='')
    print()

