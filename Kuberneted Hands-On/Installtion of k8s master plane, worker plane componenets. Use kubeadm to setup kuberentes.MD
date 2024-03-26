# To set up a Kubernetes cluster with Kubernetes Master and Worker nodes using kubeadm and install Jenkins for CI/CD, follow these steps

1. Set up an AWS EC2 instance for the Kubernetes Master node.

2. Install Kubernetes Master components on the EC2 instance:

# Update and upgrade the system
```
sudo apt-get update -y
sudo apt-get upgrade -y
```

# Install Docker
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```

# Add user to docker group
```
sudo usermod -aG docker $USER
```

# Install kubeadm, kubelet, and kubectl
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://packages.cloud.google.com/apt kubernetes-flannel-1.6 all" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubeadm=1.21.0-00 kubelet=1.21.0-00 kubectl=1.21.0-00
```
# Disable swap
```
sudo swapoff -a
sudo sed -i '/swap/s/^/#/' /etc/fstab
```

3. Initialize the Kubernetes cluster:
```
sudo kubeadm init --pod-network-cidr=0.0.0.0/0
```

4. Copy the join command for the Worker nodes:
```
sudo cat /etc/kubernetes/admin.conf | grep -E 'kubelet\s+--api-servers' | cut -d' ' -f4-
```

5. Set up an AWS EC2 instance for the Kubernetes Worker nodes.

6. Join the Worker nodes to the Kubernetes cluster:
```
kubeadm join <master_ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

7. Install Flannel for network overlay:
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

8. Install Jenkins on the Master node:

# Install Java
```
sudo apt-get install default-jdk -y
```
# Install Jenkins
```
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
```
# Start and enable Jenkins
```
sudo systemctl enable jenkins
sudo systemctl start jenkins
```
# Add Jenkins user to docker group
```
sudo usermod -aG docker jenkins
```

9. Configure Jenkins to interact with Kubernetes:
    
    a. Install kubectl on the Jenkins Master node.
 
    b. Add the kubectl binary to the Jenkins user's $PATH.

    c. Update the /etc/sudoers file to allow Jenkins user to run kubectl without password.


10. Create a Jenkins pipeline to deploy applications to Kubernetes:

     a. Create a Jenkinsfile in the root of your repository.

     b. Use the kubectl command in the Jenkinsfile to deploy applications to Kubernetes.
