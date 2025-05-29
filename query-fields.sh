#!/bin/bash

read -r -p "Enter target org: " target_org
read -r -p "Enter sObjects to query (space separated list): " -a objects
read -r -p "Enter a jq select query to filter fields by: " query

for object in "${objects[@]}"; do
    env printf "\n\e[1;34m-----\n\u279C Querying ${object}...\n-----\e[0m\n"
    sf sobject describe --sobject "${object}" --target-org "${target_org}" | jq "[(.fields | .[] | select(${query})) | .name ]" >"${object}".json
done
