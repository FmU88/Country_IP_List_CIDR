#!/bin/sh

echo  -n "Entry Country_id : "
read country

# Download data from registries
wget -nv https://ftp.apnic.net/stats/apnic/delegated-apnic-latest -O delegated-apnic-latest.txt
cat delegated-apnic-latest.txt | grep "$country" > delegated-apnic-latest-$country.txt

# Generate country codes
awk -F '|' '{ print $2 }' delegated-*-latest-$country.txt | sort | uniq | grep -E '['$country']{2}' > country_code-$country.txt

# Generate country ip blocks
 grep "|ipv4|" delegated-*-latest-$country.txt | awk -F '|' '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > ${country}_IPv4.txt
