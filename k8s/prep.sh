#!/bin/bash

# Get account ID and cluster name using AWS CLI (modify if needed)
account_id=$(aws sts get-caller-identity --query Account --output text)
cluster_name=$(aws eks list-clusters --query "clusters[0]" --output text)
region=$(aws configure get region --output text)

echo "AWS region: $region"

aws eks --region "$region" update-kubeconfig --name $cluster_name
# Validate input (optional)
# Add checks for valid account ID format (e.g., using a regex) and non-empty cluster name

# Update the YAML file
sed -i "s/account-id/${account_id}/g" cluster-autoscaler.yaml
sed -i "s/cluster-name/${cluster_name}/g" cluster-autoscaler.yaml

# Success message
echo "Cluster Autoscaler YAML file updated with account ID: $account_id and cluster name: $cluster_name"
