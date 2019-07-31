require "json"

module Gauntlt
  module Support
    module AttackAliasHelper
      GAUNTLT_DIR = Dir.pwd
      ATTACK_ALIASES_DIR = File.join(GAUNTLT_DIR, 'attack_aliases')
      ATTACK_ALIASES_GLOB_PATTERN = ATTACK_ALIASES_DIR + '/*.json'

      def gauntlt_attack_aliases
        @gauntlt_attack_aliases ||= {}
      end

      def load_attack_alias(alias_name, *version)
        @attack_steps = import_attack_aliases
        @alias_versioned = ""
        @alias_versioned << alias_name
        if version.length > 0
            @alias_versioned << "-"
            @alias_versioned << version[0]
        end

        print "Checking #{@alias_versioned} and #{alias_name}"

        if @attack_steps.has_key?(@alias_versioned)
            @attack_steps[@alias_versioned]
        elsif @attack_steps.has_key?(alias_name)
            @attack_steps[alias_name]
        else
            raise("Unknown attack alias #{alias_name}, try gauntlt --list_attack_aliases")
        end
      end

      def import_attack_aliases
         @imported_attack_aliases = Hash.new
         attack_aliases_json = Dir.glob(ATTACK_ALIASES_GLOB_PATTERN)
         Kernel.puts attack_aliases
         attack_aliases_json.each do |file|
           Kernel.puts "file: #{JSON.load(File.open(file))}"
         @imported_attack_aliases.merge!(JSON.load(File.open(file)))
         end
         @imported_attack_aliases
      end

    end
  end
end

World(Gauntlt::Support::AttackAliasHelper)

