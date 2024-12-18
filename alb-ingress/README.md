Ingress &Controller Creation
============================
1. Launch cluster
- Check if there are any resources
- $ kubectl get nodes
- $ kubectl get pods
2. Deploy ingress controller
- this will create a number of resources
- This will also create an ALB
- ref: https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.7/deploy/installation/
3. Check to see resources created, this will be in the ingress-nginx namespace
$ kubectl get all -n ingress-nginx

Adding controller to the cluster
================================
This details process to deploy an ingress controller. We will explore how to deploy the controller using YAML manifests.
1. Install cert-manager
$ kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.12.3/cert-manager.yaml
- check for latest version
- https://github.com/cert-manager/cert-manager/releases
- v1.16.2
2. Download the spec for the Load Balancer Controller(LBC)
$ wget https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.7.2/v2_7_2_full.yaml
- check for latest version
- https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/
- v2.11.0
3. Update the saved yaml file, go to the Deployment spec, and set the controller --cluster-name arg value to your EKS cluster name
- Replace <your-cluster-name> with the actual cluster name you have deployed
4. If you use IAM roles for service accounts, we recommend that you delete the ServiceAccount from the yaml spec. 
- Remember, if you delete the installation section from the yaml spec, deleting the ServiceAccount preserves the eksctl created iamserviceaccount.
5. Apply the yaml file
$ kubectl apply -f v2_7_2_full.yaml
- give the version you have downloaded
6. Optionally download the default ingressclass and ingressclass params
$ wget https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.7.2/v2_7_2_ingclass.yaml
- check for latest version
- https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases
- v2.11.0
7. Apply the ingressclass and params
$ kubectl apply -f v2_7_2_ingclass.yaml
- give the version you have downloaded
EOF 
That's it, All good!
Ref: https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.11/deploy/installation/

Deploy your application
=======================
1. Create a namespace
- models
2. Deployments
- $ kubectl -n models apply -f app1-deployment.yaml 
- $ kubectl -n models apply -f app2-deployment.yaml
2. Services
- Create NodePort or ClusterIp service types
- $ kubectl -n models apply -f app1service.yaml
- $ kubectl -n models apply -f app2service.yaml
3. Check all resources in your namespace
- $ kubectl get all -n models

Deploy ingress
==============
- Deploy in the same namespace as deployments
- $ kubectl -n models apply -f ingress.yaml
- This will deploy the rules, pointing to the services
