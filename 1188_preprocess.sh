#!/bin/bash

set -e

#wget http://cdn.hackathon.bi/data/1188/sample_1M/ope-search/ope-search.csv

echo "id;created_at;params" > ope-search_preprocess.csv
cat ope-search.csv | sed -e 's/""/"/g' | sed 's/";/"/g' | sed "s/\"{/{/g" | sed "s/}\"/}/g" | sed "s/:null/:\"null\"/g" | tr "\t" " " >> ope-search_preprocess.csv
head ope-search_preprocess.csv
