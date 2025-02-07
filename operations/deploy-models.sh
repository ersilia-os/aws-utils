WD=$PWD
DEPLOYMENTS_DIR="$WD/.deployments"
DEPLOYMENT_NAME=$(date -u +'%Y-%m-%d_%H-%M')

mkdir -p $DEPLOYMENTS_DIR

cd "helm/model-deployments"

helm dependency update

echo "Render deployment template..."
helm template test . --dry-run=server > $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml

echo "Validate deployment..."
kubeconform -summary $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml

if [ "$?" != "0" ]; then
  echo "Template validation failed! Stopping installation."
  exit 1
fi

echo "Applying deployment..."
kubectl apply -f $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml

git add $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml
git commit -m "Deployment completed [$DEPLOYMENT_NAME]"
git push