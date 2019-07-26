require 'cucumber'

out = StringIO.new

begin
  adapters_dir = "./attack_adapters"

  args = [ '--require', adapters_dir ]
  args +=  %w[attacks/osquery-os-version.attack --strict]
  args += %w[--format json]

  cli = Cucumber::Cli::Main.new(args, nil, out)
  configuration = cli.configuration
  runtime = Cucumber::Runtime.new(configuration)

  runtime.run!
rescue Exception => e
  puts e
ensure
  puts out.string
end
