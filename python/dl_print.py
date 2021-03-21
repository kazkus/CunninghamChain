# $Id$

import pandas as pd
import numpy as np

def get_dl_df():
  return pd.read_csv('data/dl.csv')

def get_table(df):
  z = np.zeros([9,9], dtype=np.int)
  for d,l,c in zip(df['d'], df['l'], df['c']):
    z[d-1,l-1] = c
  return z
#
def print_table(z):
  print(' \\', end='')
  for j in range(9):
    print('|', end='')
    print('%8d' % (j+1), end='')
  print()
  #
  print('-' * 2,end='')
  for j in range(9):
    print('+', end='')
    print('-' * 8, end='')
  print()
  #
  for i in range(9):
    print('%2d' % (i+1), end='')
    for j  in range(9):
        print('|', end='')
        c = z[i,j]
        s = ' ' * 8
        if c > 0:
          s = '%8d' % c
        print(s, end='')
    print()

def main():
  df = get_dl_df()
  z = get_table(df)
  print_table(z)

if __name__ == '__main__':
  main()

