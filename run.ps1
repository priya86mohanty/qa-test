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
#return

docker stop $privateRegistryContainerName
docker rm $privateRegistryContainerName
docker run -d -p ${registryLocalPort}:5000 --name $privateRegistryContainerName registry:2

#docker rmi ${backendImageName}:${backendVersionTag}
docker rmi ${frontendImageName}:${frontendVersionTag}
docker rmi ${automationImageName}:${automationVersionTag}
#docker rmi ${ipAddress}:${registryLocalPort}/${backendImageName}:${backendVersionTag}
docker rmi ${ipAddress}:${registryLocalPort}/${frontendImageName}:${frontendVersionTag}
docker rmi ${ipAddress}:${registryLocalPort}/${automationImageName}:${automationVersionTag}

#docker build -t ${backendImageName} .\backend\
#docker tag ${backendImageName}:${backendVersionTag} ${ipAddress}:${registryLocalPort}/${backendImageName}:${backendVersionTag}
docker push ${ipAddress}:${registryLocalPort}/${backendImageName}:${backendVersionTag}

docker build -t ${frontendImageName} .\frontend\
docker tag ${frontendImageName}:${frontendVersionTag} ${ipAddress}:${registryLocalPort}/${frontendImageName}:${frontendVersionTag}
docker push ${ipAddress}:${registryLocalPort}/${frontendImageName}:${frontendVersionTag}
return
#docker build -t ${automationImageName} .\automation\
#docker tag ${automationImageName}:${automationVersionTag} ${ipAddress}:${registryLocalPort}/${automationImageName}:${automationVersionTag}
#docker push ${ipAddress}:${registryLocalPort}/${automationImageName}:${automationVersionTag}

kind delete cluster --name test-cluster

kind create cluster --config ./Deployment/kind-cluster.yaml

kubectl label nodes test-cluster-worker node=node1
kubectl label nodes test-cluster-worker2 node=node2

docker network connect kind $privateRegistryContainerName

Start-Sleep -Seconds 5

kubectl apply -f .\Deployment\backend-Deployment.yaml
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

kubectl apply -f .\Deployment\automation-Deployment.yaml