#/bin/bash

function fun_setup_locale(){
    # Step 1: Create locale files for en_US, en_US.UTF-8, zh_TW and zh_TW.UTF-8
    sudo locale-gen en_US en_US.UTF-8 zh_TW zh_TW.UTF-8

    # Step 2: Reconfigures packages after they have already been installed
    sudo dpkg-reconfigure locales
}

function fun_install_docker(){
    # for https transport
    [ -e /usr/lib/apt/methods/https ] || {
      sudo apt-get -y update
      sudo apt-get -y install apt-transport-https
    }

    # for apt-key
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

    # update the apt-repository
    echo "deb https://get.docker.io/ubuntu docker main" | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get -y update

    # install the docker
    sudo apt-get -y install lxc-docker
}


