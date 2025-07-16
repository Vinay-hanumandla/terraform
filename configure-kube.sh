#!/bin/bash

CLUSTER_NAME="dev-eks-cluster"  #update your cluster name 
REGION="us-east-1"    #update cluster region

echo "[*] Updating kubeconfig for cluster: $CLUSTER_NAME"

aws eks update-kubeconfig \
  --name $CLUSTER_NAME \
  --region $REGION

if [ $? -eq 0 ]; then
  echo "[✓] kubeconfig updated successfully!"
  kubectl get nodes
else
  echo "[✗] Failed to update kubeconfig."
fi
