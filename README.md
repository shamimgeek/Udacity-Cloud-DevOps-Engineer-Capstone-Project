# Udacity Cloud DevOps Engineer Capstone Project

This is the final project to graducate at [Udacity Cloud DevOps Nanodegree](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991). The project requires to setup k8s cluster on AWS and deploy the dockerized app implementing CI/CD with Jenkins.

## Technology Used:
- EKS
- Jenkins
- Golang
- Docker
- Kubernetes
- CloudFormation
- Makefile
- Anchore inline scan

# Generate kube-config file

```
$ aws eks --region ap-southeast-2 update-kubeconfig --kubeconfig kube-config --name CapstoneEKSDev-EKS-CLUSTER
```

# Check cluster info

```
$ kubectl cluster-info --kubeconfig kube-config
Kubernetes master is running at https://66AF3943FCBF4D659CAA070022E7DF43.yl4.ap-southeast-2.eks.amazonaws.com
CoreDNS is running at https://66AF3943FCBF4D659CAA070022E7DF43.yl4.ap-southeast-2.eks.amazonaws.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy


```

# List Pods

```
$ kubectl --kubeconfig kube-config get nodes
NAME                                                STATUS   ROLES    AGE     VERSION
ip-192-168-113-51.ap-southeast-2.compute.internal   Ready    <none>   7m47s   v1.16.13-eks-2ba888
ip-192-168-186-60.ap-southeast-2.compute.internal   Ready    <none>   7m41s   v1.16.13-eks-2ba888
ip-192-168-207-51.ap-southeast-2.compute.internal   Ready    <none>   7m45s   v1.16.13-eks-2ba888

```

## Check List
  - [x] Network Template
  - [x] EKS Template
  - [x] Jenkins Template
  - [x] Golang Simple app
  - [x] Dockerfile
  - [x] K8s Deployment Template
  - [x] Jenkinsfile

