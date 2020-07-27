aws cloudformation create-stack \
--stack-name "capstone-project-user" \
--template-body file://user.yaml \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=ap-southeast-2
