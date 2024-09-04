#!/bin/bash

echo "----------------------------"
echo $(date)
echo "----------------------------"

export ENGINE=$MKITE_CFG/engines/redis-hydrogen.yaml

SUBMIT="kitedb submit $ENGINE"

#$SUBMIT -r vasp.rpbe.relax
#$SUBMIT -r vasp.rpbe.static
#$SUBMIT -r catalysis.surfgen
#$SUBMIT -r catalysis.supercell
#$SUBMIT -r catalysis.coverage
$SUBMIT -r conformer.generation
