Create storage account
    
    az login

    terraform init
    terraform apply


    az aks get-credentials -n k8s -g learnaks --admin
    az aks get-credentials -n k8s -g learnaks

    kubectl apply -f https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/aspnetapp.yaml

    kubectl get ingress

    terraform destroy

Install permissions via helm chart, set developer and viewer group ids

    helm upgrade --install aks-permissions .\aks_permissions\ 