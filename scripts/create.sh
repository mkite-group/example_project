#!/bin/bash

echo "----------------------------"
echo $(date)
echo "----------------------------"

WORKFLOW_DIR="$PWD/../workflows"

CREATE_SIMPLE="kitedb create_from_file simple"
CREATE_TUPLE="kitedb create_from_file tuple"

$CREATE_SIMPLE $WORKFLOW_DIR/02_conformer.yaml
