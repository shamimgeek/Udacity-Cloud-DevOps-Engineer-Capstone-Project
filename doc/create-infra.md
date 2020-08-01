# Create Infra in AWS

1. Clone the repo
   ```
   git clone git@github.com:shamimgeek/Udacity-Cloud-DevOps-Engineer-Capstone-Project.git
   cd Udacity-Cloud-DevOps-Engineer-Capstone-Project
   ```
2. Available make options
   ```
   [sakhtar@linux]$ make

   Usage:
     make <target>

   Targets:
     create-infra	Create whole infra
     delete-infra	Delete whole infra

     create-user      Create IAM User
     delete-user      Delete IAM User
     update-user      Update IAM User
     create-network   Create VPC, Subnet etc.
     delete-network   Delete network, VPC, Subnet etc.
     update-network   Update network, VPC, Subnet etc.
     create-eks-cluster  Create EKS Cluster
     delete-eks-cluster  Delete EKS Cluster
     update-eks-cluster  Update EKS Cluster
     create-node-group  Create node group
     delete-node-group  Delete node group
     update-node-group  Update node group
     update-kube-config  Update kube-config
     create-config-auth  Create aws-auth configmap
     delete-config-auth  Delete aws-auth configmap
     update-config-auth  Update aws-auth configmap
     create-jenkins-network  Create Jenkins network
     delete-jenkins-network  Delete Jenkins network
     update-jenkins-network  Update Jenkins network
     create-jenkins-host  Create Jenkins host
     delete-jenkins-host  Delete Jenkins host
     update-jenkins-host  Update Jenkins host
     help             Displays this help screen
   [sakhtar@linux]$ 
   ```
3. Create Infra
   ```
   make create-infra
   ```
4. Update kube-config
   ```
   aws eks --region ap-southeast-2 update-kubeconfig --kubeconfig kube-config --name CapstoneEKSDev-EKS-CLUSTER
   ```
5. Crate aws-auth config map
   ```
   change arn in file then apply
   [sakhtar@linux]$ kubectl --kubeconfig=kube-config apply -f infra/eks/aws-auth-cm.yaml 
   configmap/aws-auth created
   [sakhtar@linux]$ 

   ```
6. Check Kubernetes Cluster
   ```
   [sakhtar@linux]$ kubectl --kubeconfig=kube-config cluster-info
   Kubernetes master is running at https://5020ABFB91CD15A2FDA9B7739EB7B690.sk1.ap-southeast-2.eks.amazonaws.com
   CoreDNS is running at https://5020ABFB91CD15A2FDA9B7739EB7B690.sk1.ap-southeast-2.eks.amazonaws.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

   To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
   [sakhtar@linux]$
   ```
7. Check k8s health
   ```
   [sakhtar@linux]$ kubectl --kubeconfig=kube-config get cs
   NAME                 STATUS    MESSAGE             ERROR
   scheduler            Healthy   ok                  
   controller-manager   Healthy   ok                  
   etcd-0               Healthy   {"health":"true"}   
   [sakhtar@linux]$

   ```
8. List k8s nodes
   ```
   [sakhtar@linux]$ kubectl --kubeconfig=kube-config get node
   NAME                                                 STATUS   ROLES    AGE     VERSION
   ip-192-168-125-141.ap-southeast-2.compute.internal   Ready    <none>   5m22s   v1.16.13-eks-2ba888
   ip-192-168-138-253.ap-southeast-2.compute.internal   Ready    <none>   5m25s   v1.16.13-eks-2ba888
   ip-192-168-250-140.ap-southeast-2.compute.internal   Ready    <none>   5m27s   v1.16.13-eks-2ba888
   [sakhtar@linux]$ 
   ```
9. Enjoy !!!
  
