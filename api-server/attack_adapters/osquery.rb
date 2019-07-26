# TODO: figure out if there's a way to namespace these step definitions

#read in JSON
When /^"osquery" is installed$/ do
  ensure_cli_installed("osqueryi")
end

When /^I launch (?:a|an) "osquery" attack with:$/ do |input|
  # see attack_adapters/support/osquery_helper.rb
  run_osquery_query input
end
