#!/bin/bash

echo "----------------------------"
echo $(date)
echo "----------------------------"

#export MKITE_CFG=$HOME/prj/mkite/configs
export ENGINE=$MKITE_CFG/engines/redis.yaml

kitedb parse $ENGINE
