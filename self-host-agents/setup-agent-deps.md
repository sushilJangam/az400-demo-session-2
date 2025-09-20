# 🚀 Self-Hosted Azure DevOps Agent – Setup Guide

When running a **self-hosted agent** (e.g., in Proxmox), you’re responsible for installing all the tools that Microsoft-hosted agents come with pre-installed.  
This guide lists the essential tools and setup steps.

---

## 🔹 1. Core System Tools
These are always required because the agent and pipelines use them:

```bash
sudo apt update
sudo apt install -y git curl wget unzip tar jq build-essential
```

- `git` → required for `checkout` step.  
- `curl/wget` → for downloads in pipelines.  
- `unzip/tar/jq` → for artifact extraction and JSON parsing.  
- `build-essential` → GCC, g++, make (needed by many npm/pip modules).  

---

## 🔹 2. Language Runtimes (install what your pipelines need)

### Node.js
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
```
Verify:
```bash
node -v
npm -v
```

### Python
```bash
sudo apt install -y python3 python3-pip
```

### Java (for Maven/Gradle builds)
```bash
sudo apt install -y openjdk-17-jdk
```

### .NET SDK
```bash
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y dotnet-sdk-8.0
```

### PowerShell (optional)
```bash
sudo apt install -y powershell
```

---

## 🔹 3. Container & Infra Tools

### Docker
```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $(whoami)
```

### Kubernetes CLI
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/
```

### Azure CLI
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

---

## 🔹 4. Optional CI/CD Helpers
- `zip` / `unzip` / `7zip` → for artifacts.  
- `rsync` → for deployments.  
- `terraform` → for infra pipelines.  
- `helm` → for Kubernetes app deployments.  

---

## 🔹 5. Verify Agent Environment
Add this step in a test pipeline to confirm tools are installed:

```yaml
steps:
- script: |
    echo "Git: $(git --version)"
    echo "Node: $(node -v)"
    echo "NPM: $(npm -v)"
    echo "Python: $(python3 --version)"
    echo "Java: $(java -version)"
    echo "Dotnet: $(dotnet --version)"
    echo "Docker: $(docker --version)"
    echo "Azure CLI: $(az version | jq -r '.\"azure-cli\"')"
  displayName: "Check installed tools"
```

---

## ✅ Recommendations
- For **workshop/demo (AZ-400)** → install only:
  - `git`, `curl`, `node.js`, `npm`, `docker`, `azure-cli`.  
- For **general DevOps agent** → add:
  - Python, Java, .NET, kubectl, terraform, helm.  