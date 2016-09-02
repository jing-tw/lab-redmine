#!/bin/bash
username=jing
ip=192.168.33.10
ssh-keygen -f ~/.ssh/known_hosts -R $ip
sshpass -p 1234 scp -o StrictHostKeyChecking=no ./common_fun.sh $username@$ip:/home/$username
sshpass -p 1234 ssh -o StrictHostKeyChecking=no -t $username@$ip ". ./common_fun.sh;fun_setup_locale;fun_install_docker"

# run redmine container
sshpass -p 1234 ssh -o StrictHostKeyChecking=no -t $username@$ip "sudo docker run -d --name some-postgres -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=redmine postgres"
sshpass -p 1234 ssh -o StrictHostKeyChecking=no -t $username@$ip "sudo docker run -p 3000:3000 -d --name some-redmine --link some-postgres:postgres redmine"

# verification
echo "== Verification =="
sshpass -p 1234 ssh -o StrictHostKeyChecking=no -t $username@$ip "sudo docker ps "
firefox http://192.168.33.10:3000
