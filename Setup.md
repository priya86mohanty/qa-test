# Setting up kubernetes environment

## Setup environment

1. In Windows, enable WSL, Hyper-V
2. Install Docker Desktop
3. Check `docker version` in `cmd` to confirm the version of docker
4. Install `KinD`
   1. Use `curl asdf` to download
   2. Place `kind.exe` in `C:\kind`
   3. Set Environment variable for Path and add the path `C:\kind`
5. Install `kubectl`
   1. Download from ``
   2. Place `kubectl.exe` in `C:\kubectl`
   3. Set Environment variable for Path and add the path `C:\kubectl`

## Setting up the code

1. Clone the repo from `github.com/....`
2. Open the code in VS Code
3. Make sure the pre-requisites are available