# To install Git on a Linux machine, follow these steps:
Update your package manager to ensure you have the latest packages available:
For Debian-based distributions (Ubuntu, Mint, etc.), use:
```
sudo apt-get update
```
For Red Hat-based distributions (Fedora, CentOS, etc.), use:
```
sudo dnf update
```
Install Git using the package manager:
For Debian-based distributions, use:
```
sudo apt-get install git-all
```
For Red Hat-based distributions, use:
```
sudo dnf install git-all
```
Verify the installation by typing:
```
git --version
```
Configure your Git username and email using the following commands, replacing Emma's name with your own:

```
git config --global user.name "Emma Paris"
git config --global user.email "eparis@atlassian.com"
```