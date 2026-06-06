module Rails
  module Guarddog
    class Configuration
      attr_writer :root
      attr_accessor :enabled_checkers, :excluded_paths, :output_format

      def initialize
        @root = nil
        @enabled_checkers = all_checkers
        @excluded_paths = %w[vendor spec test node_modules]
        @output_format = :console
      end

      def root
        @root || Rails.root.to_s
      end

      def all_checkers
        %w[
          sql_injection xss csrf mass_assignment open_redirect secrets
          dos idor ai_injection rate_limit dependency graphql
        ]
      end
    end
  end
end