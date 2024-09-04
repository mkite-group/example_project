#!/bin/bash

echo "----------------------------"
echo $(date)
echo "----------------------------"

#export MKITE_CONFIGS=$HOME/prj/mkite/configs
#export MKITE_ENV=$MKITE_CONFIGS/db/lc-coverage.env
export ENGINE=$MKITE_CFG/engines/redis.yaml

SUBMIT="kitedb submit $ENGINE"

#$SUBMIT -r vasp.rpbe.relax
#$SUBMIT -r vasp.rpbe.static
#$SUBMIT -r catalysis.surfgen
#$SUBMIT -r catalysis.supercell
#$SUBMIT -r catalysis.coverage
$SUBMIT -r conformer.generation
