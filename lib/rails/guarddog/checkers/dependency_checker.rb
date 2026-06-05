module Rails
  module Guarddog
    module Checkers
      class DependencyChecker < BaseChecker
        def run
          gemfile = File.join(@root, 'Gemfile.lock')
          return [] unless File.exist?(gemfile)
          
          content = File.read(gemfile)
          
          # Check for typosquatted gems
          if content.match?(/raills|raill\s|rails-rails|active-model/) 
            add_finding(
              severity: :critical,
              message: "Possible typosquatted gem detected in Gemfile.lock",
              file: gemfile,
              line: 1,
              remediation: "Verify gem names carefully; check rubygems.org"
            )
          end
          
          findings
        end
      end
    end
  end
end
