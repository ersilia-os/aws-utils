WD=$PWD
DEPLOYMENTS_DIR="$WD/.deployments/models"
DEPLOYMENT_NAME=$(date -u +'%Y-%m-%d_%H-%M')
DEPLOYMENT_NAMESPACE="eos-models"
HELM_PATH="helm/model-deployments"

mkdir -p $DEPLOYMENTS_DIR

cd $HELM_PATH

helm dependency update

echo "Render deployment template..."
helm template ersilia . --namespace $DEPLOYMENT_NAMESPACE --dry-run=server > $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml

echo "Validate deployment..."
kubeconform -summary $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml

if [ "$?" != "0" ]; then
  echo "Template validation failed! Stopping installation."
  exit 1
fi

echo "Applying deployment..."
kubectl apply -f $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml

git add $DEPLOYMENTS_DIR/$DEPLOYMENT_NAME.yaml
git add .
git commit -m "chore: Deployment completed [$HELM_PATH - $DEPLOYMENT_NAME]"
git push