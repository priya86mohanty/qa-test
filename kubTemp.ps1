# variables
$backendImageName = "backend"
$frontendImageName = "frontend"
$automationImageName = "automation"
$backendVersionTag = "latest"
$frontendVersionTag = "latest"
$automationVersionTag = "latest"

$privateRegistryContainerName = "my-private-registry"
$registryLocalPort = 6000

$ipAddress =  "192.168.29.141"
#$ipAddress = (Get-IPAddress | Where-Object -FilterScript { $_.AddressFamily -Eq ("IPv4") -and $_.SuffixOrigin -Eq ("Dhcp")} ).IPAddress
$ipAddress

#kind delete cluster --name test-cluster

#kind create cluster --config ./Deployment/kind-cluster.yaml

#kubectl label nodes test-cluster-worker node=node1
#kubectl label nodes test-cluster-worker2 node=node2

#docker network connect kind $privateRegistryContainerName

#Start-Sleep -Seconds 5

kubectl apply -f .\Deployment\backend-config.yaml
kubectl apply -f .\Deployment\backend-deployment.yaml
kubectl apply -f .\Deployment\frontend-deployment.yaml

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

#kubectl apply -f .\Deployment\automation-Deployment.yaml