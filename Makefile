# Project settings
VERSION ?= 0.0.1

# Make settings
.DEFAULT_GOAL := help

# Make goals
## create-infra: ## Create whole infra
create-infra: create-user create-network create-jenkins-network create-jenkins-host create-node-group create-eks-cluster 
	# create-config-auth

## delete-infra: ## Delete whole infra
delete-infra: delete-node-group delete-eks-cluster delete-jenkins-host delete-jenkins-network delete-network delete-user

create-user: ## Create IAM User
	./infra/user/run-user.sh create

delete-user: ## Delete IAM User
	./infra/user/run-user.sh delete

update-user: ## Update IAM User
	./infra/user/run-user.sh update

create-network: ## Create VPC, Subnet etc.
	./infra/eks/run-network.sh create
	sleep 90

delete-network: ## Delete network, VPC, Subnet etc.
	./infra/eks/run-network.sh delete
	sleep 90

update-network: ## Update network, VPC, Subnet etc.
	./infra/eks/run-network.sh update
	sleep 90

create-eks-cluster: ## Create EKS Cluster
	./infra/eks/run-cluster.sh create

delete-eks-cluster: ## Delete EKS Cluster
	./infra/eks/run-cluster.sh delete
	sleep 120

update-eks-cluster: ## Update EKS Cluster
	./infra/eks/run-cluster.sh update

create-node-group: ## Create node group
	./infra/eks/run-node-group.sh create

delete-node-group: ## Delete node group
	./infra/eks/run-node-group.sh delete
	sleep 120

update-node-group: ## Update node group
	./infra/eks/run-node-group.sh update

update-kube-config: ## Update kube-config
	aws eks --region ap-southeast-2 update-kubeconfig --kubeconfig kube-config --name CapstoneEKSDev-EKS-CLUSTER

create-config-auth: ## Create aws-auth configmap
	kubectl create -f ./infra/eks/aws-auth-cm.yaml

delete-config-auth: ## Delete aws-auth configmap
	kubectl delete -f ./infra/eks/aws-auth-cm.yaml

update-config-auth: ## Update aws-auth configmap
	kubectl apply -f ./infra/eks/aws-auth-cm.yaml

create-jenkins-network: ## Create Jenkins network
	./infra/jenkins/run-network.sh create
	sleep 90

delete-jenkins-network: ## Delete Jenkins network
	./infra/jenkins/run-network.sh delete

update-jenkins-network: ## Update Jenkins network
	./infra/jenkins/run-network.sh update

create-jenkins-host: ## Create Jenkins host
	./infra/jenkins/run-jenkins.sh create
	sleep 120

delete-jenkins-host: ## Delete Jenkins host
	./infra/jenkins/run-jenkins.sh delete

update-jenkins-host: ## Update Jenkins host
	./infra/jenkins/run-jenkins.sh update

help: ## Displays this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n \033[36m create-infra\033[0m\tCreate whole infra\n \033[36m delete-infra\033[0m\tDelete whole infra\n\n"} /^[a-zA-Z_-]+:.*?##/ \
	{ printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
