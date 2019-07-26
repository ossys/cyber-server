require 'aruba'

module Gauntlt
  module Support
    module OsqueryHelper
      def run_osquery_query(query)
        #args = args.join(' ')
        command = "osqueryi '#{query}' --csv --logger_min_status 1"

        run command
      end
    end
  end
end

World(Gauntlt::Support::OsqueryHelper)
