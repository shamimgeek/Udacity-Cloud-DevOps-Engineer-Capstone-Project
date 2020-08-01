#!/bin/bash

ACTION=$1
STACK="capstone-project-network"
TEMPLATE="${PWD}/infra/jenkins/network.yaml"
PARAMS="${PWD}/infra/jenkins/parameters.json"

${PWD}/infra/jenkins/run.sh $ACTION $STACK $TEMPLATE $PARAMS
