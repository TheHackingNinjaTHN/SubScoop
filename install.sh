#!/bin/bash

# Install jp2a
echo "Installing jp2a..."
sudo apt-get update
sudo apt-get install -y jp2a

# Install lolcat
echo "Installing lolcat..."
sudo gem install lolcat

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
