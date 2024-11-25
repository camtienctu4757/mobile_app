#!/bin/bash
for i in {1..10000}; do
  curl -X 'GET' \
    'http://localhost:5000/api/v1/products/get_r?cache=asdf' \
    -H 'accept: application/json'
done
