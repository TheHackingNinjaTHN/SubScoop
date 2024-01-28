#!/bin/bash

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

# Check and install missing tools

# Function to check if a command exists
check_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a command if it doesn't exist
install_if_missing() {
    if ! check_command_exists "$1"; then
        echo "Installing $1..."
        sudo apt-get install -y "$1"
        if [ $? -ne 0 ]; then
            echo "Failed to install $1. Please install it manually."
            exit 1
        fi
    fi
}

# List of tools to check and install
tools=("jp2a" "lolcat" "cargo" "make" "perl")

# Iterate through the tools and install if missing
for tool in "${tools[@]}"; do
    install_if_missing "$tool"
done

# Install Rust
if ! check_command_exists "rustup"; then
    echo "Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable
    source $HOME/.cargo/env
    export PATH="$HOME/.cargo/bin:$PATH" >> ~/.bash_profile
fi

# Check and install Go tools
go_tools=("subfinder" "amass" "httprobe")

# Iterate through Go tools and install if missing
for tool in "${go_tools[@]}"; do
    if ! check_command_exists "$tool"; then
        echo "Installing $tool..."
        GO111MODULE=on go install -v github.com/projectdiscovery/$tool/v2/cmd/$tool@latest
        mv $GOPATH/bin/$tool /usr/bin/
    fi
done

# Check and install Python tools
python_tools=("sublist3r" "SubDomainizer")

# Iterate through Python tools and install if missing
for tool in "${python_tools[@]}"; do
    if ! check_command_exists "$tool"; then
        echo "Installing $tool..."
        git clone https://github.com/nsonaniya2010/$tool.git
        cd $tool
        pip install -r requirements.txt
        chmod +x ${tool}.py
        mv ${tool}.py /usr/bin/
        cd ..
        rm -rf $tool
    fi
done

# Install Findomain
if ! check_command_exists "findomain"; then
    echo "Installing Findomain..."
    git clone https://github.com/Findomain/Findomain.git
    cd Findomain
    cargo build --release
    mv target/release/findomain /usr/bin/
    cd ..
    rm -rf Findomain
fi

echo "Installation completed."
