#!/bin/bash

ACTION=$1
STACK="capstone-project-eks-network"
TEMPLATE="${PWD}/infra/eks/eks-cluster-network.yaml"
PARAMS="${PWD}/infra/eks/parameters.json"

${PWD}/infra/eks/run.sh $ACTION $STACK $TEMPLATE $PARAMS
