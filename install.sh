#!/bin/bash

# Install lolcat
sudo apt-get -y install lolcat
lolcat -v
echo -e "Installing all the required tools and dependencies" | lolcat -a -s 50 
echo -e "Be Patient and have a Scoop of Ice Cream" | lolcat -a -s 50
echo -e "Version: v1.0             by Nikhil soni" | lolcat -a -s 50 
echo -e "Installing all the required tools and dependencies" | lolcat -a -s  50
sleep 4s
echo -e "\e[1;32m[================================================================================================================================================]" | lolcat -a -s 10  | pv -qL 50 

jp2a --colors --width=60 subscoop.png 
echo ":'######:'##::::'##'########::'######::'######::'#######::'#######:'########:: 
'##... ##:##:::: ##:##.... ##'##... ##'##... ##'##.... ##'##.... ##:##.... ##:
 ##:::..::##:::: ##:##:::: ##:##:::..::##:::..::##:::: ##:##:::: ##:##:::: ##:
. ######::##:::: ##:########:. ######::##:::::::##:::: ##:##:::: ##:########::
:..... ##:##:::: ##:##.... ##:..... ##:##:::::::##:::: ##:##:::: ##:##.....:::
'##::: ##:##:::: ##:##:::: ##'##::: ##:##::: ##:##:::: ##:##:::: ##:##::::::::
. ######:. #######::########:. ######:. ######:. #######:. #######::##::::::::
:......:::.......::........:::......:::......:::.......:::.......::..:::::::::" | lolcat  -a -s 50

# Install GO
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

# Install Cargojp2a
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
# Creating a directory tools
mkdir -p tools
cd tools

# Install dependencies
sudo apt -y install libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev build-essential libssl-dev libffi-dev libldns-dev jq ruby-full python3-setuptools python3-dnspython rename findutils

# Install Subfinder
sudo apt install subfinder -y

# Install Amass
git clone https://github.com/mrnitesh/amass.git
cd amass
chmod+x script.sh
sudo ./script.sh
cd ..

# Install Dnsx
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
sudo cp /root/go/bin/dnsx /usr/bin

# Install Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd sublist3r/
pip3 install -r requirements.txt
cd ../

# Install Github-Search
git clone https://github.com/gwen001/github-search.git

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
sudo cp SubDomainizer.py /usr/bin/
cd ..


# Install Knockpy
git clone https://github.com/guelfoweb/knock.git
cd knock
pip3 install -r requirements.txt
cd ..


echo -e "Installation completed." | lolcat -a -s 100
