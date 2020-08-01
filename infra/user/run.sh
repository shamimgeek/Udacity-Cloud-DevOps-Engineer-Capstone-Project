#!/bin/bash

ACTION=$1

case $ACTION in

  create)
    aws cloudformation create-stack \
    --stack-name $2 \
    --template-body file://$3 \
    --region=ap-southeast-2 \
    --capabilities CAPABILITY_NAMED_IAM
    ;;

  update)
    aws cloudformation update-stack \
    --stack-name $2 \
    --template-body file://$3 \
    ;;

  delete)
    aws cloudformation delete-stack \
    --stack-name $2 \
    --region=ap-southeast-2
    ;;

  *)
    echo -n "unknown argument, expecting (create | update | delete)"
    ;;
esac
