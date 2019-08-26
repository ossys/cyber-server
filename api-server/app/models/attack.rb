# frozen_string_literal: true

require 'cucumber'
require 'json'

class Attack
  ATTACK_FILES_DIR = File
                .expand_path('../../attacks', __dir__)
                .freeze

  ADAPTERS_DIR = File
                 .expand_path('../../lib/attack_adapters', __dir__)
                 .freeze

  attr_reader :result

  def initialize(file_name)
    @result = StringIO.new
    @args = build_args(file_name)
    @runtime = build_runtime
  end

  def run!
    @runtime.run!
    JSON.parse(@result.string)
  end

  def build_args(file_name)
    args = ['--require', ADAPTERS_DIR, AttackFile.file_path(file_name)]
    args += %w[--strict --format json]
  end

  def build_runtime
    cli = Cucumber::Cli::Main.new(@args, nil, @result)
    configuration = cli.configuration
    runtime = Cucumber::Runtime.new(configuration)
    runtime
  end
end
