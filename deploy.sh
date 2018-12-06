#!/bin/bash

function deploy_ui {
    echo "--------------------------DEPLOYING UI-----------------------------"
<<<<<<< HEAD
    echo "Building and pushing docker image..."    
    cd $ROOT_DIRECTORY/ui/build
    docker build . -t donkey-koin/ui:latest
    docker tag donkey-koin/ui:latest localhost:6000/donkey-koin/ui:latest
    docker push localhost:6000/donkey-koin/ui:latest
=======
    # echo "Building and pushing docker image..."    
    cd ui
    # docker build . -t donkey-koin/ui:latest
    # docker tag donkey-koin/ui:latest localhost:6000/donkey-koin/ui:latest
    # docker push localhost:6000/donkey-koin/ui:latest
    # cd ..
>>>>>>> epyepy registry

    echo "Applying k8s resources..."    
    cd $ROOT_DIRECTORY/ui
    kubectl delete --ignore-not-found -f deployment.yaml -n donkey-koin
    kubectl apply -f deployment.yaml -n donkey-koin
    kubectl apply -f service.yaml -n donkey-koin
    echo "------------------------------------------------------------------"
    echo "UI deployed successfully!"
    echo "------------------------------------------------------------------"
}

function deploy_orchestration {
    echo "------------------DEPLOYING ORCHESTRATION--------------------------"
    # echo "Building and pushing docker image..."    
    # cd orchestrations
    # docker build . -t donkey-koin/orchestration:latest
    # docker tag donkey-koin/orchestration:latest localhost:6000/donkey-koin/orchestration:latest
    # docker push localhost:6000/donkey-koin/orchestration:latest
    # cd ..

    echo "Applying k8s resources..." 
    cd $ROOT_DIRECTORY/orchestration   
    kubectl delete --ignore-not-found -f deployment.yaml -n donkey-koin
    kubectl apply -f deployment.yaml -n donkey-koin
    kubectl apply -f service.yaml -n donkey-koin
    echo "------------------------------------------------------------------"
    echo "Orchestration deployed successfully!"
    echo "------------------------------------------------------------------"
}

function deploy_exchange {
    echo "------------------DEPLOYING EXCHANGE SERVICE----------------------"
<<<<<<< HEAD
    echo "Building and pushing docker image..."    
    cd $ROOT_DIRECTORY/exchange-service/build
    docker build . -t donkey-koin/exchange-service:latest
    docker tag donkey-koin/exchange-service:latest localhost:6000/donkey-koin/exchange-service:latest
    docker push localhost:6000/donkey-koin/exchange-service:latest

    echo "Applying k8s resources..."    
    cd $ROOT_DIRECTORY/exchange-service
=======
    # echo "Building and pushing docker image..."    
    cd exchange-service
    # docker build . -t donkey-koin/exchange-service:latest
    # docker tag donkey-koin/exchange-service:latest localhost:6000/donkey-koin/exchange-service:latest
    # docker push localhost:6000/donkey-koin/exchange-service:latest

    echo "Applying k8s resources..."    
    # cd ..
>>>>>>> epyepy registry
    kubectl delete --ignore-not-found -f deployment.yaml -n donkey-koin
    kubectl apply -f deployment.yaml -n donkey-koin
    kubectl apply -f service.yaml -n donkey-koin
    echo "------------------------------------------------------------------"
    echo "Exchange service deployed successfully!"
    echo "------------------------------------------------------------------"
}

function deploy_transaction {
    echo "------------------DEPLOYING TRANSACTION SERVICE-------------------"
<<<<<<< HEAD
    echo "Building and pushing docker image..."    
    cd $ROOT_DIRECTORY/transaction-service/build
    docker build . -t donkey-koin/transaction-service:latest
    docker tag donkey-koin/transaction-service:latest localhost:6000/donkey-koin/transaction-service:latest
    docker push localhost:6000/donkey-koin/transaction-service:latest
=======
    # echo "Building and pushing docker image..."    
    cd transaction-service
    # docker build . -t donkey-koin/transaction-service:latest
    # docker tag donkey-koin/transaction-service:latest localhost:6000/donkey-koin/transaction-service:latest
    # docker push localhost:6000/donkey-koin/transaction-service:latest
    # cd ..
>>>>>>> epyepy registry

    echo "Applying k8s resources for mongodb..."  
    cd $ROOT_DIRECTORY/transaction-service/dependencies
    kubectl delete --ignore-not-found -f mongo-db-deployment.yaml -n donkey-koin
    kubectl apply -f mongo-pv.yaml -n donkey-koin
    kubectl apply -f mongo-db-deployment.yaml -n donkey-koin
    kubectl apply -f mongo-db-service.yaml -n donkey-koin
    echo "Mongo deployed successfully!"
    echo "------------------------------------------------------------------"

    echo "Applying k8s resources for transaction service..."    
    kubectl delete --ignore-not-found -f deployment.yaml -n donkey-koin
    kubectl apply -f deployment.yaml -n donkey-koin
    kubectl apply -f service.yaml -n donkey-koin
    echo "------------------------------------------------------------------"
    echo "Transaction service deployed successfully!"
    echo "------------------------------------------------------------------"
}

function create_namespace {
    cd $ROOT_DIRECTORY/infra
    kubectl apply -f namespace.yaml
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

create_namespace

if [ $UI = true ]; then
    deploy_ui
fi

if [ $ORCHESTRATION = true ]; then
    deploy_orchestration
fi

if [ $EXCHANGE_SERVICE = true ]; then
    deploy_exchange
fi

if [ $TRANSACTION_SERVICE = true ]; then
    deploy_transaction
fi

