#!/usr/bin/env bash

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file=./ansible/hosts -u ubuntu --private-key=./keys/cyber ./ansible/build.yml
