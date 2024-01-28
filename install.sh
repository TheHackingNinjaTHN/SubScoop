#!/bin/bash

echo -e "Installing all the required tools and dependencies" | lolcat
echo -e "Be Patient and have a Scoop of Ice Cream" | lolcat
echo -e "Version: v1.0             by Nikhil soni" | lolcat
echo -e "Installing all the required tools and dependencies" | lolcat
sleep 4s
echo -e "\e[1;32m[================================================================================================================================================]" | lolcat |pv -qL 50

jp2a --colors --width=60 subscoop.png 
echo ":'######:'##::::'##'########::'######::'######::'#######::'#######:'########:: 
'##... ##:##:::: ##:##.... ##'##... ##'##... ##'##.... ##'##.... ##:##.... ##:
 ##:::..::##:::: ##:##:::: ##:##:::..::##:::..::##:::: ##:##:::: ##:##:::: ##:
. ######::##:::: ##:########:. ######::##:::::::##:::: ##:##:::: ##:########::
:..... ##:##:::: ##:##.... ##:..... ##:##:::::::##:::: ##:##:::: ##:##.....:::
'##::: ##:##:::: ##:##:::: ##'##::: ##:##::: ##:##:::: ##:##:::: ##:##::::::::
. ######:. #######::########:. ######:. ######:. #######:. #######::##::::::::
:......:::.......::........:::......:::......:::.......:::.......::..:::::::::" | lolcat


# Check if GOPATH is set
if [[ -z "$GOPATH" ]]; then
    echo "GOPATH is not set. Installing Go and setting environment variables..."
    wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
    sudo tar -xvf go1.13.4.linux-amd64.tar.gz
    sudo mv go /usr/local
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
    echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
    echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_profile
    source ~/.bash_profile
fi

# Install Python and other dependencies
sudo apt-get install -y python-dnspython python-pip python3-pip python-setuptools ruby-full build-essential libssl-dev libffi-dev python-dev


# Install jp2a
sudo apt -y install jp2a

# Install lolcat
sudo apt-get -y install lolcat

# Install Cargo
sudo apt-get -y install cargo

# Install make
sudo apt-get -y install make

# Install Perl
sudo apt-get -y install perl

# Install Rust
if ! command -v "rustup" &>/dev/null; then
    echo "Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable
    source $HOME/.cargo/env
    export PATH="$HOME/.cargo/bin:$PATH" >> ~/.bash_profile
else
    echo -e "${GREEN}Rust is installed.${NC}"
fi

# Install Subfinder
GO111MODULE=on go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo mv /root/go/bin/subfinder /usr/bin

# Install Amass
git clone https://github.com/mrnitesh/amass.git
cd amass
chmod+x script.sh
sudo ./script.sh

# Install httprobe
go install -y github.com/tomnomnom/httprobe
sudo cp /root/go/bin/httprobe /usr/bin

# Install Sublist3r
# sudo apt-get -y install sublist3r


# Install Findomain
git clone https://github.com/Findomain/Findomain.git
cd Findomain
cargo build --release
mv target/release/findomain /usr/bin/
cd ..
rm -rf Findomain

# Install SubDomainizer
git clone https://github.com/nsonaniya2010/SubDomainizer.git
cd SubDomainizer
pip3 install -r requirements.txt
sudo mv SubDomainizer.py /usr/bin/

# Install Knockpy
git clone https://github.com/guelfoweb/knock.git
cd knock
python3 setup.py install
knockpy -v

# Install Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
sudo pip install -r requirements.txt

# Install Subbrute
git clone https://github.com/TheRook/subbrute.git
cd subbrute
sudo cp subbrute.py /usr/bin


echo -e "Installation completed." | lolcat
