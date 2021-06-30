Create storage account for terraform state

Configure variables in `terraform/var.auto.tfvars` and `terraform/var.backend.tfvars`
    
    az login

    tf-init.ps1
    terraform apply


    az aks get-credentials -n k8s -g learnaks --admin
    az aks get-credentials -n k8s -g learnaks

    kubectl apply -f https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/aspnetapp.yaml

    kubectl get ingress

    terraform destroy

Install permissions via helm chart, set developer and viewer group ids

    helm upgrade --install aks-permissions .\aks_permissions\ 

# Azure Container Registry

An azure container registry is created and the default account in all configured namespaces is allowed access to read from it.

This is done by adding the secret `acr-image-pull-secret` to each namespace and adding it to the image pull secrets of the default account.

Specify variable `aks_additional_namespaces` to add more namespaces.