kind delete cluster --name test-cluster

kind create cluster --config ./Deployment/kind-cluster.yaml

kubectl label nodes test-cluster-worker node=node1
kubectl label nodes test-cluster-worker2 node=node2

Start-Sleep -Seconds 5

kubectl apply -f .\Deployment\backend-config.yaml
kubectl apply -f .\Deployment\backend-Deployment.yaml
kubectl apply -f .\Deployment\frontend-config.yaml
kubectl apply -f .\Deployment\frontend-Deployment.yaml

while ($true)
{
    $pods = kubectl get pods -o json | ConvertFrom-json
    $backendStatus = $pods.items[0].status.phase
    $frontendStatus = $pods.items[1].status.phase
    $status
    if($backendStatus -Eq "Running" -and $frontendStatus -Eq "Running")
    {
        break
    }

    Start-Sleep -Seconds 1
}

kubectl apply -f .\Deployment\automationtest-deployment.yaml