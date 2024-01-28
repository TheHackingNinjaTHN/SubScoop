#!/bin/bash

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if GOPATH is set
: <<'COMMENT'
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
COMMENT

# Install Python and other dependencies
sudo apt-get install -y python-dnspython python-pip python3-pip python-setuptools ruby-full build-essential libssl-dev libffi-dev python-dev

# Function to install a command if it doesn't exist
install_if_missing() {
    if ! command -v "$1" &>/dev/null; then
        echo -e "${RED}Installing $1...${NC}"
        sudo apt-get install -y "$1"
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to install $1. Please install it manually.${NC}"
            exit 1
        fi
    else
        echo -e "${GREEN}$1 is installed.${NC}"
    fi
}

# List of tools to check and install
tools=("jp2a" "lolcat" "cargo" "make" "perl")

# Iterate through the tools and install if missing
for tool in "${tools[@]}"; do
    install_if_missing "$tool"
done

# Install Rust
if ! command -v "rustup" &>/dev/null; then
    echo "Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable
    source $HOME/.cargo/env
    export PATH="$HOME/.cargo/bin:$PATH" >> ~/.bash_profile
else
    echo -e "${GREEN}Rust is installed.${NC}"
fi

# Check and install Go tools
 go_tools=("subfinder" "amass" "httprobe")
 Iterate through Go tools and install if missing
 for tool in "${go_tools[@]}"; do
     install_if_missing "$tool"
 done

# Install Sublist3r
# sudo apt-get -y install sublist3r


# Install Findomain
if ! check_command_exists "findomain"; then
    echo "Installing Findomain..."
    git clone https://github.com/Findomain/Findomain.git
    cd Findomain
    cargo build --release
    mv target/release/findomain /usr/bin/
    cd ..
    rm -rf Findomain
    if [ $? -ne 0 ]; then
        echo -e "\033[0;31mFailed to install Findomain. Please install it manually.\033[0m"
        exit 1
    else
        echo -e "\033[0;32mFindomain is installed.\033[0m"/
    fi
fi

# Install SubDomainizer
git clone https://github.com/nsonaniya2010/SubDomainizer.git
cd SubDomainizer
pip3 install -r requirements.txt
mv SubDomainizer.py /usr/bin/

# Install Knockpy
git clone https://github.com/guelfoweb/knock.git
cd knock
python3 setup.py install
knockpy -v

# Install Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
sudo pip install -r requirements.txt



echo "Installation completed."
