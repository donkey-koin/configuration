#!/bin/bash

EXCHANGE_SERVICE=false
TRANSACTION_SERVICE=false
ORCHESTRATION=false
UI=false

if [ $# -eq 0 ]; then
    echo "------------------------------------------------------------------"
    echo "-------------------------ERROR------------------------------------"
    echo "Pass proper params: "
    echo "--ui - to deploy ui"
    echo "--orchestration - to deploy orchestration"
    echo "--exchange - to deploy exchange service"
    echo "--transaction - to deploy transaction service"
    echo "------------------------------------------------------------------"
    echo "------------------------------------------------------------------"
    exit
fi


while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --ui)
    UI=true
    shift
    ;;
    --orchestration)
    ORCHESTRATION=true
    shift 
    ;;
    --exchange)
    EXCHANGE_SERVICE=true
    shift 
    ;;
    --transaction)
    TRANSACTION_SERVICE=true
    shift 
    ;;
esac
done

echo "------------------------------------------------------------------"
echo "------------------STARTING DEPLOYMENT SCRIPT----------------------"
echo "Deploying UI: $UI" 
echo "Deploying orchestration: $ORCHESTRATION"
echo "Deploying transaction service $TRANSACTION_SERVICE"
echo "Deploying exchange service: $EXCHANGE_SERVICE"
echo "------------------------------------------------------------------"
echo "------------------------------------------------------------------"


