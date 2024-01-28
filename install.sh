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

# Install jp2a
echo "Installing jp2a..."
sudo apt-get update
sudo apt-get install -y jp2a

# Install lolcat
echo "Installing lolcat..."
sudo apt-get -y install lolcat

# Install Subfinder
echo "Installing Subfinder..."
GO111MODULE=on go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
mv $GOPATH/bin/subfinder /usr/bin/

# Install Sublist3r
echo "Installing Sublist3r..."
pip install sublist3r
mv /usr/local/bin/sublist3r /usr/bin/

# Install SubDomainizer
echo "Installing SubDomainizer..."
git clone https://github.com/nsonaniya2010/SubDomainizer.git
cd SubDomainizer
pip install -r requirements.txt
chmod +x SubDomainizer.py
mv SubDomainizer.py /usr/bin/

# Install Subbrute
echo "Installing Subbrute..."
git clone https://github.com/TheRook/subbrute.git
cd subbrute
chmod +x subbrute.py
mv subbrute.py /usr/bin/

# Install Amass
echo "Installing Amass..."
GO111MODULE=on go install -v github.com/OWASP/Amass/v3/...@latest
mv $GOPATH/bin/amass /usr/bin/

# Install Findomain
echo "Installing Findomain..."
git clone https://github.com/Findomain/Findomain.git
cd Findomain
cargo build --release
mv target/release/findomain /usr/bin/

# Install httprobe
echo "Installing httprobe..."
GO111MODULE=on go install -v github.com/tomnomnom/httprobe@latest
mv $GOPATH/bin/httprobe /usr/bin/

echo "Installation completed."
