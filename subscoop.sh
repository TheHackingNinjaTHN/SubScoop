#!/bin/bash

jp2a --colors --width=60 superman.png | lolcat

# Process command-line arguments
while getopts ":u:h" opt; do
    case ${opt} in
        u )
            domain=$OPTARG
            
            # Perform subdomain enumeration using subfinder, amass, sublist3r, knockpy, findomain, subbrute, and subdomainizer and save output to subdomains.txt
            echo -e "\e[32mPerforming subdomain enumeration...\e[0m"
            printf "\e[1;33m[Running Subfinder]\e[0m\n"
            subfinder -d "$domain" -all -silent > subdomains.txt || { echo -e "\e[31mError: subfinder failed.\e[0m"; }
            printf "\e[1;33m[Running Amass]\e[0m\n \e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            amass enum -d "$domain" >> subdomains.txt || { echo -e "\e[31mError: amass failed.\e[0m"; }
            printf "\e[1;33m[Running Sublist3r]\e[0m\n \e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            /sublist3r/sublist3r.py -d "$domain" >> subdomains.txt || { echo -e "\e[31mError: sublist3r failed.\e[0m"; }
            printf "\e[1;33m[Running Knockpy]\e[0m\n \e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            knockpy "$domain" -silent >> subdomains.txt || { echo -e "\e[31mError: knockpy failed.\e[0m"; }
            printf "\e[1;33m[Running Findomain]\e[0m\n \e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            findomain -t "$domain" >> subdomains.txt || { echo -e "\e[31mError: findomain failed.\e[0m"; }
            printf "\e[1;33m[Running Subbrute]\e[0m\n \e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            subbrute.py "$domain" >> subdomains.txt || { echo -e "\e[31mError: subbrute failed.\e[0m"; }
            printf "\e[1;33m[Running SubDomainizer]\e[0m\n \e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            subdomainizer -u http://"$domain" >> subdomains.txt || { echo -e "\e[31mError: subdomainizer failed.\e[0m"; }
            printf "[Subdomain Enumeration Completed] \e[32m[#######################################]\e[0m \e[1;31mDone.\e[0m\n\n" | pv -qL 35
            echo
            echo
            sleep 0.5
            echo
            echo
            # Sorting and filtring uniq subdomains
            printf "\e[1;33m[Filtering Unique SubDomains]\e[0m\n"
            cat subdomains.txt | sort -u | uniq > uniqsubs.txt

            # Use httprobe to filter out live hosts from subdomains.txt
            printf "\e[1;33m[Filtering Live SubDomains]\e[0m\n"
            cat uniqsubs.txt | httprobe > live_hosts.txt || { echo -e "\e[31mError: httprobe failed.\e[0m"; }
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
