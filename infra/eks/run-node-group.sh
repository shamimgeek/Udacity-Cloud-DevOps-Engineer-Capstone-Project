#!/bin/bash

ACTION=$1
STACK="capstone-project-eks-node-group"
TEMPLATE="${PWD}/infra/eks/eks-nodegroup.yaml"
PARAMS="${PWD}/infra/eks/parameters.json"

${PWD}/infra/eks/run.sh $ACTION $STACK $TEMPLATE $PARAMS
