#!/bin/bash

jp2a --colors --width=100 superman.png | lolcat
cat superman.txt

# Check if a command exists
check_command_exists() {
    command -v "$1" >/dev/null 2>&1 || {
        printf "\e[31m$1 command not found. Skipping...\e[0m\n"
        return 1
    }
}

# Check if required commands exist
check_command_exists subfinder || continue
check_command_exists amass || continue
check_command_exists sublist3r || continue
check_command_exists knockpy || continue
check_command_exists findomain || continue
check_command_exists subdomainizer || continue
check_command_exists httprobe || continue
check_command_exists subbrute || continue

# Process command-line arguments
while getopts ":u:h" opt; do
    case ${opt} in
        u )
            domain=$OPTARG
            
            # Perform subdomain enumeration using subfinder, amass, sublist3r, knockpy, findomain, subbrute, and subdomainizer and save output to subdomains.txt
            echo -e "\e[32mPerforming subdomain enumeration...\e[0m"
            printf "\e[1;33m[RUNNING]\e[0m\n"
            subfinder "$domain" -all -silent > subdomains.txt || { echo -e "\e[31mError: subfinder failed.\e[0m"; }
            amass enum -d "$domain" >> subdomains.txt || { echo -e "\e[31mError: amass failed.\e[0m"; }
            sublist3r -d "$domain" >> subdomains.txt || { echo -e "\e[31mError: sublist3r failed.\e[0m"; }
            knockpy "$domain" >> subdomains.txt || { echo -e "\e[31mError: knockpy failed.\e[0m"; }
            findomain -t "$domain" >> subdomains.txt || { echo -e "\e[31mError: findomain failed.\e[0m"; }
            subbrute "$domain" >> subdomains.txt || { echo -e "\e[31mError: subbrute failed.\e[0m"; }
            subdomainizer -u "$domain" >> subdomains.txt || { echo -e "\e[31mError: subdomainizer failed.\e[0m"; }
            printf "\e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            echo -e "\e[32mSubdomain enumeration completed. Checking for live hosts...\e[0m"
            echo
            sleep 0.5
            echo
            
            # Use httprobe to filter out live hosts from subdomains.txt
            printf "\e[1;33m[RUNNING]\e[0m\n"
            httprobe < subdomains.txt > live_hosts.txt || { echo -e "\e[31mError: httprobe failed.\e[0m"; }
            printf "\e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            echo -e "\e[32mLive hosts identification completed. Check 'live_hosts.txt' for results.\e[0m"
            echo
            sleep 0.5
            echo
            
            echo -e "\e[35mSubdomain enumeration completed successfully.\e[0m"
            ;;
        h )
            printf "Usage: %s -u domain_name\n" "$0"
            exit 0
            ;;
        \? )
            printf "\e[31mInvalid option: $OPTARG\e[0m\n"
            exit 1
            ;;
        : )
            printf "\e[31mInvalid option: $OPTARG requires an argument\e[0m\n"
            exit 1
            ;;
    esac
done
