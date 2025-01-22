#!/bin/bash

# Function to print usage instructions
usage() {
    echo "Usage: $0 <target> <start_port> <end_port>"
    echo "Example: $0 192.168.1.1 20 100"
    exit 1
}

# Check if the required number of arguments is provided
if [ $# -ne 3 ]; then
    usage
fi

# Assign arguments to variables
TARGET=$1
START_PORT=$2
END_PORT=$3
TIMEOUT=1

# Inform the user that the scan is starting
echo "Scanning $TARGET from port $START_PORT to $END_PORT..."

# Loop through the range of ports and check if they are open
for PORT in $(seq $START_PORT $END_PORT); do
    # Use netcat (nc) to check if the port is open
    nc -z -v -w $TIMEOUT $TARGET $PORT &>/dev/null
    
    # If the port is open, nc returns 0; otherwise, it returns a non-zero value
    if [ $? -eq 0 ]; then
        echo "Port $PORT is OPEN"
    else
        echo "Port $PORT is CLOSED"
    fi
done

echo "Scan completed."
