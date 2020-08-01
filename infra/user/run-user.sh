#!/bin/bash

ACTION=$1
STACK="capstone-project-user"
TEMPLATE="$PWD/infra/user/user.yaml"

${PWD}/infra/user/run.sh $ACTION $STACK $TEMPLATE
