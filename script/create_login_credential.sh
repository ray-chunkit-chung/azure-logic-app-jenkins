#!/bin/bash

# https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?toc=%252fazure%252fazure-resource-manager%252ftoc.json
# See all available role 
# az role definition list -o table

# Create a service principal with required parameter
# az ad sp create-for-rbac --scopes /subscriptions/$SUBSCRIPTION_NAME

# Create a service principal for a resource group using a preferred name and role
az ad sp create-for-rbac --name $ServicePrincipalName \
                         --role Contributor \
                         --scopes /subscriptions/$SUBSCRIPTION_NAME/resourceGroups/$RESOURCEGROUP_NAME
