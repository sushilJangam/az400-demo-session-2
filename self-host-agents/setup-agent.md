# Create agent directory and move into it
mkdir myagent && cd myagent

# Install curl if not already installed
sudo apt update && sudo apt install -y curl

# Download the latest Azure DevOps agent package
curl -O https://download.agent.dev.azure.com/agent/3.252.0/vsts-agent-linux-x64-3.252.0.tar.gz

# Extract the package
tar -xzf vsts-agent-linux-x64-3.252.0.tar.gz

# Configure the agent
./config.sh

# Config Output 
Enter server URL > https://dev.azure.com/<ORG_NAME>
Enter authentication type (press enter for PAT) >
Enter personal access token > <PAT_TOKEN>
Enter agent pool (press enter for default) > <POOL_NAME>
Enter agent name (press enter for <hostname>) > <AGENT_NAME>
Enter work folder (press enter for _work) > 


# Install as a service
sudo ./svc.sh install

# Start the service
sudo ./svc.sh start

# Check service status
sudo ./svc.sh status