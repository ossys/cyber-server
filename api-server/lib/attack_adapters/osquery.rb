require 'cucumber'

#read in JSON
When /^"osquery" is installed$/ do
  ensure_cli_installed("osqueryi")
end

When /^I launch (?:a|an) "system" query with:$/ do |input|
  # see attack_adapters/support/osquery_helper.rb
  run_osquery_query input
end

When /^I launch (?:a|an) "node" query with:$/ do |input|
  # see attack_adapters/support/osquery_helper.rb
  run_osquery_query input
end

When /^I launch (?:a|an) "remote" query on node "([\w-]+)" named "([\w-]+)" with:$/ do |node_key, query_name, query_body|
  @result = AdHocQuery.run(node_key, query_name, query_body)
end

Then /^the output should contain:$/ do |text|
  p @result
  expect(@result.include?(text)).to eq(true)
end

#When /^I launch (?:a|an) "osquery-(.*?)" query$/ do |type|
  #osquery_version = get_cli_version("osqueryi")
  #attack_alias = 'osquery-' + type
  #attack = load_attack_alias(attack_alias, osquery_version)

  #Kernel.puts "Running a(n) #{attack_alias} attack. This attack has this description:\n #{attack['description']}"

  #Kernel.puts "The #{attack_alias} attack requires the following to be set in the profile:\n #{attack['requires']}"

  #run_osquery_query attack['command']
#end
