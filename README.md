# qa-test

**Kubernetes Deployment:**

Deploy the services to a local Kubernetes cluster (e.g., Minikube or Kind).

**Verification:**

- Ensure the frontend service can successfully communicate with the backend service.
- Verify that accessing the frontend URL displays the greeting message fetched from the backend.

**Automated Testing:**

- Write a simple test script (using a tool of your choice) to verify the integration between the frontend and backend services.
- The test should check that the frontend correctly displays the message returned by the backend.

**Documentation:**

- Provide a README file with instructions on how to set up and run the automated tests script.

**Deliverables:**

- Test script for automated testing.
- README file with setup and execution instructions.

**Github repo should be Public**

-----------------------------------------

# Setting up kubernetes environment

## Setup environment

1. In Windows, enable WSL, Hyper-V
2. Install Docker Desktop
   1. Download Docker Desktop from <https://www.docker.com/products/docker-desktop/>
   2. Check `docker version` in `cmd` to confirm the version of docker
3. Install `KinD`
   1. Use `curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.24.0/kind-windows-amd64` to download `kind`
   2. Rename downloaded file to `kind.exe`
   3. Place `kind.exe` in `C:\kind`
   4. Set Environment variable for Path and add the path `C:\kind`
4. Install `kubectl`
   1. Use `curl.exe -LO "https://dl.k8s.io/release/v1.31.0/bin/windows/amd64/kubectl.exe"` to download `kubectl`
   2. Place `kubectl.exe` in `C:\kubectl`
   3. Set Environment variable for Path and add the path `C:\kubectl`

## Setting up the code

1. Clone the repo from (<https://github.com/priya86mohanty/qa-test>)
2. Checkout the branch `automation`
3. Open the code in VS Code

## Setting up the kubernetes cluster and verify frontend and backend integration

1. Run the powershell file `run.ps1`
2. Check the pod creation status using the command `kubectl get pods`
3. Once this completed, please use the following command to check if the tests were successful `kubectl logs -f <automation-pod-name>`

## Deliverables

1. Public GitHub Repository - <https://github.com/priya86mohanty/qa-test>
2. Test script for automated testing - Available under `.\K8MsTest\KubernetesTest.cs`

## Python program

1. Public GitHub Repository for Python programs - <https://github.com/priya86mohanty/PythonProgramAssessment>
