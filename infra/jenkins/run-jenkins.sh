#!/bin/bash

ACTION=$1
STACK="capstone-project-jenkins"
TEMPLATE="${PWD}/infra/jenkins/jenkins.yaml"
PARAMS="${PWD}/infra/jenkins/parameters.json"

${PWD}/infra/jenkins/run.sh $ACTION $STACK $TEMPLATE $PARAMS
