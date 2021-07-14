#!/bin/bash

create_dataset() {
    echo `curl -s https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/$1.geojson` | jq '.features[]' | jq '[.properties.place, .geometry.coordinates[0,1], .properties.mag]' | jq '((.[2]|tostring) + "|" + (.[1]|tostring) + "|" + .[0] + "|" + (.[3]|tostring))' | jq -r . > hour.chi
    ./cliapp -i hour.chi --dataset-name $1
    rm hour.chi
    echo "Dataset '$1' created."
}

create_dataset 'all_hour'
create_dataset 'all_day'
create_dataset 'all_week'