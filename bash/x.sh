#!/bin/bash

D=data/x
F=$D/x.csv

echo 'l,p' > $F
cat $D/*.out | grep '^CC' | sed -e 's/ 2021-0[3-9]-.*//' -e 's/^CC//' -e 's/:/ /' -e 's/ /,/' | sort -t ',' -k2n -u >> $F

