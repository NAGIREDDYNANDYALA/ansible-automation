#!/bin/bash
sudo yum update -y
sudo yum install -y python-boto python-boto3
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo amazon-linux-extras install ansible2 -y
sudo yum install ansible -y
sudo bash -c "cat /etc/ansible/ansible.cfg | sed 's/basic default values.../basic default values...\ninventory      = \/etc\/ansible\/hosts/g' | sed 's/basic default values...\nsudo_user     = root/g' > /etc/ansible/ansible.cfg.replacement"
sudo cp /etc/ansible/ansible.cfg.replacement /etc/ansible/ansible.cfg
sudo mv /etc/ansible/hosts /etc/hosts.original
sudo bash -c 'echo "[local]" > /etc/ansible/hosts' && sudo bash -c 'echo "localhost ansible_connection=local" >> /etc/ansible/hosts'
sudo useradd ansible
#echo 'ansible' | sudo -S passwd ansible # Note the password of ansible user here is ansible
sudo bash -c "cat /etc/sudoers | sed 's/.*group to run networking.*/ansible    ALL=(ALL)    NOPASSWD: ALL\n\n&/' | sed 's/.*group to run networking.*/ec2-user    ALL=(ALL)    NOPASSWD: ALL\n\n&/' > /etc/sudoers.placeholder"
sudo cp /etc/sudoers.placeholder /etc/sudoers