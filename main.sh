#!/bin/bash

# Request DNS address from user
read -p "Please enter the DNS address: " dns_address

# Check DNS using dig
echo "Checking DNS address..."
dig_output=$(dig @$dns_address google.com)

# Display results
if echo "$dig_output" | grep -q "ANSWER SECTION"; then
    echo "The DNS address is valid."
    
    # Extract information from dig_output
    response_time=$(echo "$dig_output" | grep "Query time" | awk '{print $4}')
    server_ip=$(echo "$dig_output" | grep "SERVER:" | awk '{print $2}')
    
    # Display response time and server IP
    echo "Response time: ${response_time} ms"
    echo "Server IP address: ${server_ip}"
    
    # Determine the country of the DNS server
    echo "Determining the country of the DNS server..."
    country=$(curl -s http://ip-api.com/json/${server_ip} | jq -r '.country')
    echo "Country of the DNS server: ${country}"
else
    echo "The DNS address is invalid or there is a problem with the connection."
fi
