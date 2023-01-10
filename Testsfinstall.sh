#!/usr/bin/env bash

rpm --import https://packages.microsoft.com/keys/microsoft.asc
cat << EOF >  /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
yum install -y code
###install python###
sudo yum update
sudo yum install python3

##install docker###
sudo yum check-update
sudo yum install -y yum-utils device-mapper-persisten-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
   ###install aws CLI###
yum install awscli -y
