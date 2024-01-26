#!/bin/bash

# Function to display progress bar
progress_bar() {
    local duration=$1
    local granularity=10
    local sleep_duration=$(echo "scale=2; $duration / $granularity" | bc)

    for ((i = 0; i <= granularity; i++)); do
        printf "\r[%-${granularity}s] %d%%" "$(< /dev/urandom tr -dc '[:alnum:]' | head -c1)" "$((i * 100 / granularity))"
        sleep $sleep_duration
    done
    printf "\n"
}

# Function to perform subdomain enumeration
subdomain_enum() {
    local domain="$1"
    echo "Performing subdomain enumeration for $domain"
    echo "Using Subfinder..."
    subfinder -d $domain >> subdomains.txt
    echo "Using Sublist3r..."
    sublist3r -d $domain >> subdomains.txt
    echo "Using SubDomainizer..."
    python3 SubDomainizer.py -u "http://www.$domain" >> subdomains.txt
    echo "Using Subbrute..."
    python3 subbrute.py $domain >> subdomains.txt
    echo "Using Gobuster..."
    gobuster dns -d $domain -w /usr/share/wordlists/dirb/common.txt >> subdomains.txt
    echo "Using Amass..."
    amass enum -d $domain >> subdomains.txt
    echo "Using Assetfinder..."
    assetfinder --subs-only $domain >> subdomains.txt
    echo "Using Findomain..."
    findomain -t $domain >> subdomains.txt
}

# Main script
if [ "$1" == "-i" ] && [ -n "$2" ]; then
    domain="$2"
    echo "Starting subdomain enumeration for $domain"
    subdomain_enum $domain &
    pid=$!
    echo "Enumerating subdomains..."
    progress_bar 60  # Adjust duration as needed
    wait $pid
    echo "Subdomain enumeration completed."
    echo "Sorting subdomains..."
    sort -u subdomains.txt -o subdomains_sorted.txt
    echo "Finding live subdomains..."
    cat subdomains_sorted.txt | httprobe > live_subdomains.txt
    echo "Task completed. Live subdomains saved in live_subdomains.txt"
else
    echo "Usage: tool.sh -i domain.com"
fi
