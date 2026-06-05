module Rails
  module Guarddog
    module Checkers
      class RateLimitChecker < BaseChecker
        def run
          config_file = File.join(@root, 'config/initializers/rack_attack.rb')
          
          if !File.exist?(config_file)
            add_finding(
              severity: :medium,
              message: "Rate limiting not configured: rack_attack.rb missing",
              file: config_file,
              line: 1,
              remediation: "Create config/initializers/rack_attack.rb with rate limiting rules"
            )
          else
            content = File.read(config_file)
            unless content.include?('throttle') && (content.include?('login') || content.include?('api'))
              add_finding(
                severity: :medium,
                message: "Rate limiting rules not configured for critical endpoints",
                file: config_file,
                line: 1,
                remediation: "Add throttle rules for /login, /api/auth, /password_reset"
              )
            end
          end
          findings
        end
      end
    end
  end
end
