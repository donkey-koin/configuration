#!/bin/bash

function deploy_exchange {
    echo "------------------DEPLOYING EXCHANGE SERVICE----------------------"
    echo "Building and pushing docker image..."    
    cd exchange-service/build
    docker build . -t donkey-koin/exchange-service
    docker tag donkey-koin/exchange-service localhost:6000/donkey-koin/exchange-service
    docker push localhost:6000/donkey-koin/exchange-service

    echo "Applying k8s resources..."    
    cd ..
    kubectl delete --ignore-not-found -f deployment.yaml -n donkey-koin
    kubectl apply -f deployment.yaml -n donkey-koin
    kubectl apply -f service.yaml -n donkey-koin
    echo "------------------------------------------------------------------"
    echo "Exchange service deployed successfully!"
    cd ..
    echo "------------------------------------------------------------------"
    cd $ROOT_DIRECTORY
}

function deploy_transaction {
    echo "------------------DEPLOYING TRANSACTION SERVICE-------------------"
    echo "Building and pushing docker image..."    
    cd transaction-service/build
    docker build . -t donkey-koin/transaction-service
    docker tag donkey-koin/transaction-service localhost:6000/donkey-koin/transaction-service
    docker push localhost:6000/donkey-koin/transaction-service
    cd ..

    echo "Applying k8s resources for mongodb..."  
    cd dependencies  
    kubectl delete --ignore-not-found -f mongo-db-deployment.yaml -n donkey-koin
    kubectl apply -f mongo-pv.yaml -n donkey-koin
    kubectl apply -f mongo-db-deployment.yaml -n donkey-koin
    kubectl apply -f mongo-db-service.yaml -n donkey-koin
    echo "Mongo deployed successfully!"
    cd ..
    echo "------------------------------------------------------------------"

    echo "Applying k8s resources for transaction service..."    
    kubectl delete --ignore-not-found -f deployment.yaml -n donkey-koin
    kubectl apply -f deployment.yaml -n donkey-koin
    kubectl apply -f service.yaml -n donkey-koin
    cd ..
    echo "------------------------------------------------------------------"
    echo "Transaction service deployed successfully!"
    echo "------------------------------------------------------------------"
    cd $ROOT_DIRECTORY
}

EXCHANGE_SERVICE=false
TRANSACTION_SERVICE=false
ORCHESTRATION=false
UI=false

ROOT_DIRECTORY=`echo $PWD`

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

echo "Started script in $ROOT_DIRECTORY"

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

if [ $UI = true ]; then
    echo "TBC"
fi

if [ $ORCHESTRATION = true ]; then
    echo "TBC"
fi

if [ $EXCHANGE_SERVICE = true ]; then
    deploy_exchange
fi

if [ $TRANSACTION_SERVICE = true ]; then
    deploy_transaction
fi

