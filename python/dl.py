# $Id$

import os
import sys
import pandas as pd
import numpy as np

sys.path.append('python')
from dl_print import print_table

def get_table():
  df = pd.read_csv('data/p.csv')
  count_df = df[['d','l','k']].groupby(['d','l']).count().reset_index(drop=False)
  #
  z = np.zeros([19,14], dtype=np.int)
  for d,l,k in zip(count_df['d'], count_df['l'], count_df['k']):
      z[d-1,l-1] = k
  return z

def main():
  z = get_table()
  print_table(z, type=0, d_max=19, l_max=14)

if __name__ == '__main__':
  main()

