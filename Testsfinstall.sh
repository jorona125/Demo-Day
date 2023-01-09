    cat << EOF > /etc/yum.repos.d/vscode.repo
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
    sudo yum install -y yum-utils
    sudo yum-config-manager \
        --add-repo\
        https://download.docker.com/linux/rhel/docker/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli container.io docker-compose-plugin

    ###install aws CLI###
    yum install awscli -y 
    
