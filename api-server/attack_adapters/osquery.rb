# TODO: figure out if there's a way to namespace these step definitions

#read in JSON
When /^"osquery" is installed$/ do
  ensure_cli_installed("osqueryi")
end

When /^I launch (?:a|an) "osquery" query with:$/ do |input|
  # see attack_adapters/support/osquery_helper.rb
  run_osquery_query input
end

When /^I launch (?:a|an) "osquery-(.*?)" query$/ do |type|
  attack_alias = 'osquery-' + type
  attack = load_attack_alias(attack_alias, [])

  Kernel.puts attack

  #Kernel.puts "Running a(n) #{attack_alias} attack. This attack has this description:\n #{attack['description']}"

  #Kernel.puts "The #{attack_alias} attack requires the following to be set in the profile:\n #{attack['requires']}"

  run_osquery_query attack['command']
end
