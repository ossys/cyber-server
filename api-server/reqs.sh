#!/usr/bin/env ruby

switch = ARGV[0]
node_key = ARGV[1] || 'no node-key'

case switch
when 'enroll-invalid'
  Kernel.system 'curl https://localhost:5000/enroll --data \'{"enroll_secret":"zecret"}\' -k'
when 'enroll'
  Kernel.system 'curl https://localhost:5000/enroll --data \'{"enroll_secret":"secret"}\' -k'
when 'dist-read-invalid'
when 'dist-read'
  Kernel.system "curl --data '{\"node_key\": \"" + node_key + "\"}' https://localhost:5000/distributed_read -k"
end

# vim: set syntax=ruby:
