#Install Postfix dependency for GitLab-CE
install_postfix(){
    dnf update
    dnf install postfix -y
    sudo systemctl enable --now postfix
}

#Install Gitlab
install_gitlab(){
    curl -O https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh
    chmod +x script.rpm.sh
    os=el dist=8 ./script.rpm.sh
    sudo dnf install gitlab-ce -y
}

#Add exceptions to http and https ports
enable_web(){
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo systemctl reload firewalld
}

#Main script
install_postfix
install_gitlab
enable_web
echo "Installation complete, please configure the gitlab.rb file manually"