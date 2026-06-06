module Rails
  module Guarddog
    class Scanner
      attr_accessor :configuration, :findings

      def initialize(config = nil)
        @configuration = config || Configuration.new
        @findings = []
      end

      def run
        load_checkers.each do |checker_class|
          checker = checker_class.new(@configuration.root)
          checker.run
          @findings.concat(checker.findings)
        end
        @findings.sort_by { |f| severity_order(f.severity) }
      end

      private

      def load_checkers
        [
          Checkers::SqlInjectionChecker,
          Checkers::XssChecker,
          Checkers::CsrfChecker,
          Checkers::MassAssignmentChecker,
          Checkers::OpenRedirectChecker,
          Checkers::SecretsChecker,
          Checkers::DosChecker,
          Checkers::IdorChecker,
          Checkers::AiInjectionChecker,
          Checkers::RateLimitChecker,
          Checkers::DependencyChecker,
          Checkers::GraphqlChecker
        ]
      end

      def severity_order(severity)
        { critical: 0, high: 1, medium: 2, low: 3 }[severity] || 4
      end
    end
  end
end
