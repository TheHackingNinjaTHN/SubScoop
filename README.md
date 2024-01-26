## Subdomain Enumeration Tool
**This shell script is designed to perform subdomain enumeration for a given domain using various subdomain enumeration tools. It utilizes several popular tools to collect subdomains, sort them, find live subdomains, and store the results in separate files.**

## Features
Enumerates subdomains using the following tools:
Subfinder
Sublist3r
SubDomainizer
Subbrute
Gobuster
Amass
Assetfinder
Findomain
Provides a progress bar to track the enumeration process.
Sorts the collected subdomains and removes duplicates.
Uses httprobe to find live subdomains.
Stores the output in text files for further analysis.
Prerequisites
Linux environment (tested on Ubuntu).
Python 3 installed.
Tools like Subfinder, Sublist3r, Gobuster, Amass, Assetfinder, Findomain, SubDomainizer, and subbrute installed and configured properly.
httprobe tool installed.

## Usage
**Clone the repository:**
```
git clone https://github.com/example/subdomain-enumeration-tool.git
```

**Navigate to the directory:**
```
cd subdomain-enumeration-tool
```

**Make the script executable:**
```
chmod +x subdomain_enum.sh
```

**Run the script with the domain as an argument:**
```
./subdomain_enum.sh -i example.com
```

**Replace example.com with the target domain.**

Below is a sample README file outlining the necessary details and instructions for using the subdomain enumeration tool:

Subdomain Enumeration Tool
This shell script is designed to perform subdomain enumeration for a given domain using various subdomain enumeration tools. It utilizes several popular tools to collect subdomains, sort them, find live subdomains, and store the results in separate files.

Features
Enumerates subdomains using the following tools:
Subfinder
Sublist3r
SubDomainizer
Subbrute
Gobuster
Amass
Assetfinder
Findomain
Provides a progress bar to track the enumeration process.
Sorts the collected subdomains and removes duplicates.
Uses httprobe to find live subdomains.
Stores the output in text files for further analysis.
Prerequisites
Linux environment (tested on Ubuntu).
Python 3 installed.
Tools like Subfinder, Sublist3r, Gobuster, Amass, Assetfinder, Findomain, SubDomainizer, and subbrute installed and configured properly.
httprobe tool installed.
Usage
Clone the repository:

bash
Copy code
git clone https://github.com/example/subdomain-enumeration-tool.git
Navigate to the directory:

bash
Copy code
cd subdomain-enumeration-tool
Make the script executable:

bash
Copy code
chmod +x subdomain_enum.sh
Run the script with the domain as an argument:

bash
Copy code
./subdomain_enum.sh -i example.com
Replace example.com with the target domain.

Output
subdomains.txt: Contains all the collected subdomains.
subdomains_sorted.txt: Contains sorted and unique subdomains.
live_subdomains.txt: Contains live subdomains found using httprobe.
Disclaimer
This tool is provided for educational and informational purposes only. Usage of this tool for any malicious activity is strictly prohibited. The developers are not responsible for any misuse of this tool.
