# To install Jenkins on a Linux machine, follow these steps:

1. Update the system packages:
```
sudo yum update
```
2. Add the Jenkins repository:
```
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/debian-stable/jenkins.repo
sudo systemctl stop firewalld
sudo systemctl disable firewalld
```

3. Import the Jenkins repository GPG key:
```
sudo rpm --import https://pkg.jenkins.io/debian-stable/jenkins.io-key
```

4. Add the Jenkins repository to the system's sources list:
```
sudo cat <<-EOF > /etc/yum.repos.d/jenkins.repo
[signed-by=/usr/share/keyrings/jenkins.gpg]
https://pkg.jenkins.io/debian-stable/jenkins.repo
```

5. Update the system's package list:
```
sudo yum update
```

6. Install Jenkins:
```
sudo yum install epel-11-openjdk-devel
sudo yum install java-11-openjdk-devel
sudo yum install jenkins
sudo systemctl start jenkins
```

7. Start Jenkins:
```
sudo systemctl start jenkins
```

8. Open the firewall:
```
sudo firewall-cmd --list-all
```

9. Install Jenkins:
```
sudo yum install jenkins
```

10. Configure Jenkins:

11. Access Jenkins through a web browser.

12. Visit Jenkins at http://<your_server_ip_or_domain:8080/











