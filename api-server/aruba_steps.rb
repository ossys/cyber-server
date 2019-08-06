Then('the output includes the message {string}') do |message|
  expect(all_stdout).to include(message)
end
