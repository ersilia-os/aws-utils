
Load Balancer Controller Installation
=====================================
Ref: https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.11/deploy/installation/

1. Create IAM OIDC provider
eksctl utils associate-iam-oidc-provider \
    --region eu-west-1 \
    --cluster h3d-eks-clusteryLeOXjKa \
    --approve
  
2. Download IAM policy for the AWS Load Balancer Controller
$ curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json
3. Create an IAM policy called AWSLoadBalancerControllerIAMPolicy
$ aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam-policy.json
4. Create an IAM role and Kubernetes ServiceAccount for the LBC. Use the ARN from the previous step.
$ eksctl create iamserviceaccount \
--cluster=h3d-eks-clusteryLeOXjKa \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::443413310934:policy/AWSLoadBalancerControllerIAMPolicy \
--override-existing-serviceaccounts \
--region eu-west-1 \
--approve

Add controller to cluster
=========================
1. Install cert-manager
$ kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.3/cert-manager.yaml
2. Download the spec for the LBC
$ wget https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.11.0/v2_11_0_full.yaml
3. Edit the saved yaml file, go to the Deployment spec, and set the controller --cluster-name arg value to your EKS cluster name
- search for deployment and replace <your-cluster-name> with your actual cluster name
4. If you use IAM roles for service accounts, we recommend that you delete the ServiceAccount from the yaml spec. If you delete the installation section from the yaml spec, deleting the ServiceAccount preserves the eksctl created iamserviceaccount.
5. Apply the yaml file
$ kubectl apply -f v2_11_0_full.yaml
6. Optionally download the default ingressclass and ingressclass params
$ wget https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.11.0/v2_11_0_ingclass.yaml
7. Apply the ingressclass and params
$ kubectl apply -f v2_11_0_ingclass.yaml

Troubleshoot
============
https://docs.aws.amazon.com/eks/latest/userguide/lbc-manifest.html
$ curl -Lo v2_11_0_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.11.0/v2_11_0_full.yaml
$ sed -i.bak -e '690,698d' ./v2_11_0_full.yaml
$ sed -i.bak -e 's|your-cluster-name|h3d-eks-clusteryLeOXjKa|' ./v2_11_0_full.yaml

Master cert troubleshoot
https://cert-manager.io/docs/troubleshooting/webhook/

ab8cae394d0b94cf8afa4080b7450ed1-1355382584.eu-west-1.elb.amazonaws.com
ab8cae394d0b94cf8afa4080b7450ed1-4e228b59de21ad76.elb.eu-west-1.amazonaws.com

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=h3d-eks-clusteryLeOXjKa --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=h3d-eks-clusteryLeOXjKa --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller

https://github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller
https://artifacthub.io/packages/helm/cert-manager/cert-manager
----------------------------------------------------------------------

h3d-eks-clusterfkB2vYcN

eksctl utils associate-iam-oidc-provider \
    --region eu-west-1 \
    --cluster h3d-eks-clusterfkB2vYcN \
    --approve
    
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

eksctl create iamserviceaccount \
--cluster=h3d-eks-clusterfkB2vYcN \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::443413310934:policy/AWSLoadBalancerControllerIAMPolicy \
--approve

Install Controller
==================
kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.2/cert-manager.yaml
https://github.com/cert-manager/cert-manager/releases/tag/v1.16.2

kubectl expose deploy frontend1 -n model-deploy --type=LoadBalancer --port=80

https://docs.aws.amazon.com/eks/latest/userguide/auto-configure-alb.html
https://docs.aws.amazon.com/eks/latest/userguide/auto-enable-existing.html
https://docs.aws.amazon.com/pdfs/eks/latest/userguide/eks-ug.pdf page 96

https://oidc.eks.eu-west-1.amazonaws.com/id/9C139C89263D01F0800BDDF38AED38F9

oidc.eks.eu-west-1.amazonaws.com/id/E0AB6BC153B15C2B015F00172310579F

arn:aws:iam::443413310934:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing

ALB DNS
=======
eks-models-571444368.eu-west-1.elb.amazonaws.com
https://kubernetes.io/docs/concepts/services-networking/service/
