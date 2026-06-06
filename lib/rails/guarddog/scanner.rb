module Rails
  module Guarddog
    class Scanner
      attr_accessor :configuration, :findings

      def initialize(config = nil)
        @configuration = config || Configuration.new
        @findings = []
      end

      def run
        checkers = load_checkers
        checkers.each do |checker|
          checker_instance = checker.new(@configuration.root)
          checker_instance.run
          @findings.concat(checker_instance.findings)
        end
        @findings.sort_by { |f| severity_order(f.severity) }
      end

      private

      def load_checkers
        checkers_dir = File.expand_path('../guarddog/checkers', __FILE__)
        Dir.glob("#{checkers_dir}/*_checker.rb").reject { |f| f.include?('base_checker') }.map do |file|
          require file
          class_name = File.basename(file, '.rb').camelize
          Checkers.const_get(class_name)
        end.compact
      end

      def severity_order(severity)
        { critical: 0, high: 1, medium: 2, low: 3 }[severity] || 4
      end
    end
  end
end
