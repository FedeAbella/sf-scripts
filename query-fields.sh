#!/bin/bash

read -p "Enter target org: " target_org
read -p "Enter sObjects to query (space separated list): " -a objects
read -p "Enter a jq select query to filter fields by: " query

for object in ${objects[@]}; do
    echo "Querying ${object}..."
    sf sobject describe --sobject ${object} --target-org ${target_org} | jq "[(.fields | .[] | select(${query})) | .name ]" >${object}.json
done
