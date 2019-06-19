#!/bin/bash

if [ -z "$1" ]
then
  echo quit | openssl s_client -showcerts -connect localhost:5000 > files/cacert.pem
else
  echo quit | openssl s_client -showcerts -connect $1 > files/cacert.pem
fi
