#!/bin/bash

set -e

# Step 1: Apply Terraform
echo "📦 Running Terraform..."
cd infra
terraform apply -auto-approve -var-file="staging.tfvars"

# Step 2: Get public IP
echo "🌐 Fetching EC2 IP..."
EC2_IP=$(terraform output -raw ec2_public_ip)

# Step 3: Run Ansible natively
echo "🔧 Running Ansible Playbook on $EC2_IP"
cd ../ansible
ansible-playbook -i "${EC2_IP}," -u ubuntu --private-key ~/.ssh/id_rsa site.yml


