# $Id$

import os
import sys
import pandas as pd

def get_df():
    df = pd.read_csv('data/p.csv')
    # print(len(df), df.columns)
    # 1354 Index(['p', 'd', 'k', 'l'], dtype='object')
    return df

def filter_df(df, d=None, k=None, l=None):
    # print(d, k, l)
    # print(df.head(10))
    if d is not None:
        df = df[df['d']==d]
    if k is not None:
        df = df[df['k']==k]
    if l is not None:
        df = df[df['l']==l]
    df = df.reset_index(drop=True)
    # print(len(df))
    return df

def print_l(df, n=100):
    df0 = df
    s = "Cunningham Chains of Length "
    a = len(s) + 2
    # print("=" * a)
    print("-" * a)
    for l in range(1,15):
    # for l in range(8,9):
        df = filter_df(df0,l=l)
        if len(df) == 0:
            continue
        print(s + str(l))
        print("-" * a)
        if len(df) > n:
            df = df.iloc[:n]
        for i,p,d in zip(range(len(df)), df['p'], df['d']):
            print('%3d %20d %2d' % (i+1,p,d))
        print("-" * a)
    # print("=" * a)
    
def main():
    df = get_df()
    # print(len(df))
    # print(df.head(10))
    print_l(df, n=100)

if __name__ == '__main__':
    main()

