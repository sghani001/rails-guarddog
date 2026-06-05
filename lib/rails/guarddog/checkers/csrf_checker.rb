module Rails
  module Guarddog
    module Checkers
      class CsrfChecker < BaseChecker
        def run
          glob_files('app/controllers/**/*.rb').each do |file|
            content = File.read(file)
            has_skip = content.include?('skip_before_action :verify_authenticity_token')
            if has_skip && !content.include?('# CSRF disabled for specific reason')
              add_finding(
                severity: :critical,
                message: "CSRF protection disabled without documented reason",
                file: file,
                line: 1,
                remediation: "Remove skip_before_action or add documented reason"
              )
            end
          end
          findings
        end
      end
    end
  end
end
