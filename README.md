# azure-logic-app
azure logic app to track new file upload to one drive. If new, add an Azure queue



# Env parameters
in .env file
```
# Deploy infra parameters
export SUBSCRIPTION_ID=foo-bar-foo-foo-bar
export SUBSCRIPTION_NAME=foo-bar-foo-foo-bar
export RESOURCEGROUP_NAME=foo-bar-foo-foo-bar
export LOCATION=eastus
export WEB_APP_NAME=foo-bar-foo-foo-bar
export CUSTOM_DOMAIN_VERIFICATION_ID=foo-bar-foo-foo-bar

# Deploy artifact parameters
export DOCKER_USERNAME=raychung

# App parameters
export WEBSITES_PORT=12345
```

# Getting started


Login Azure
```
az login
```

Create resource group (Assume a subscription exists)
```
az group create --subscription $SUBSCRIPTION_NAME \
                --location $LOCATION \
                --name $RESOURCEGROUP_NAME \
                --tags "$TAGS"
```

Create storage account
```
az storage account create --subscription $SUBSCRIPTION_NAME \
                          --name $STORAGE_NAME \
                          --resource-group $RESOURCEGROUP_NAME
```

Create queues in storage account
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/queue/template.json
```
<!-- ```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/queue/template.json \
                           --parameters ArmTemplate/queue/parameters.json

az storage queue create --subscription $SUBSCRIPTION_NAME \
                        --name $STORAGE_QUEUE_NAME \

az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicApp/template.json
``` -->


Create api connection to one drive and queue in this resource group
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/api_queue/template.json
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/api_onedrive/template.json
```

Create logic app to connect one drive and queue
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicApp/template.json
```

Start the logic app
```
az logicapp start --subscription $SUBSCRIPTION_NAME \
                  --resource-group $RESOURCEGROUP_NAME \
                  --name $LOGICAPP_NAME
```



# Delete everything

```
az group delete --name $RESOURCEGROUP_NAME
```



# az login by service principal 
https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli#4-sign-in-using-a-service-principal

```
az login --service-principal --username appID --password PASSWORD --tenant tenantID
```

```
az ad sp create-for-rbac --name $ServicePrincipalName --role contributor --scopes /subscriptions/$SUBSCRIPTION_ID
```