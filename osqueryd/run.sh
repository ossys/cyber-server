#!/usr/bin/env ruby
# vi:syntax=ruby

switch = ARGV[0]

def help
  puts <<-END
  Helper for running osqueryd for tests.

  Available commands:
    * run [flagfile path] [config file path]
    * cleanup
  END
end

def cleanup
  Kernel.system "rm -rf run/*"
end

def run_osquery
  flag_file = ARGV[1]

  default_config_file = File.join('configs', 'default-linux.json')
  config_file = ARGV[2].nil? ? default_config_file : ARGV[2]

  run_hash = ('a'..'z').to_a.shuffle[0,8].join.freeze
  Dir.mkdir(File.join('run', run_hash))

  osqueryd_flags = [
    '--database_path=./db',
    '--pidfile=./pidfile',
    '--logger_path=.',
    "--config_path=../../#{config_file}",
    "--flagfile ../../#{flag_file}"
  ].join(" ").freeze

  puts osqueryd_flags
  Kernel.system "cd run/#{run_hash} rm *; osqueryd #{osqueryd_flags}"
end

case switch
when 'run'
  run_osquery
when 'clean'
  cleanup
else
  help
end
