require 'cucumber'
require 'json'

class Attack
    ATTACKS_DIR = File
      .expand_path('../../../attacks', __FILE__)
      .freeze

    ADAPTERS_DIR = File
      .expand_path("../../../lib/attack_adapters", __FILE__)
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
      args = [ '--require', ADAPTERS_DIR, Attack.file_path(file_name) ]
      args +=  %w[--strict --format json]
    end

    def build_runtime
      cli = Cucumber::Cli::Main.new(@args, nil, @result)
      configuration = cli.configuration
      runtime = Cucumber::Runtime.new(configuration)
      runtime
    end

    def self.attack_files
      Dir
        .entries(ATTACKS_DIR)
        .select{|e| !File.directory?(e) }
    end

    def self.file_path(file_name)
      File.join(ATTACKS_DIR, file_name)
    end
end
