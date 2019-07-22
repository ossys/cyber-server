require 'gauntlt'
require 'cucumber'

out = $stdin

begin
  adapters_dir = "attack_adapters"

  args =  ["attacks/generic.attack"] + [ '--strict', '--no-snippets', '--require', adapters_dir ]
  args += ['--format', "json"]
  args += ['--out', "c.out"]

  Cucumber::Cli::Main.new(args).execute!
rescue SystemExit
  a = out.gets
  p a
end
