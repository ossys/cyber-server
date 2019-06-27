#!/bin/bash

cd /opt;

tar -xzvf osquery-3.3.2_1.linux_x86_64.tar.gz -C osquery;

cp -rl osquery/etc /etc;
cp -rl osquery/usr /usr;
cp -rl osquery/var /var;
