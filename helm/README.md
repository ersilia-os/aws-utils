CMD
===
$ helm dep update
$ helm install aws-load-balancer-controller ./aws-load-balancer-controller -n kube-system
$ helm delete aws-load-balancer-controller ./aws-load-balancer-controller -n kube-system

ingress-nginx
=============
$ helm install ingress-nginx ./ingress-nginx -n models
$ helm delete ingress-nginx ./ingress-nginx -n models
