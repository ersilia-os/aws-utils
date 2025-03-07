CMD
===
$ helm dep update
$ helm install aws-load-balancer-controller ./aws-load-balancer-controller -n ingress-nginx 
$ helm delete aws-load-balancer-controller ./aws-load-balancer-controller -n ingress-nginx 

ingress-nginx
=============
$ helm install ingress-nginx ./ingress-nginx -n ingress-nginx 
$ helm delete ingress-nginx ./ingress-nginx -n ingress-nginx 
$ helm install ingress-nginx ./ingress-nginx -n ingress-nginx 
$ helm delete ingress-nginx ./ingress-nginx -n ingress-nginx 

If getting access Denied error in the aws-load-balancer-controller pod, please ensure to deploy the serviceAccount.yaml
