#!/bin/bash


for i in `seq 2000`; do perl -e '$z=time()+(10*60); while (time()<$z) { $j++; $sqrt = sqrt($j) for (1..9999); }' & done
