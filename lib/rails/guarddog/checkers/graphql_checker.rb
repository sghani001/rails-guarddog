module Rails
  module Guarddog
    module Checkers
      class GraphqlChecker < BaseChecker
        def run
          glob_files('app/graphql/**/*.rb').each do |file|
            content = File.read(file)
            
            if content.include?('field') || content.include?('def resolve')
              unless content.include?('authorize') || content.include?('current_user')
                add_finding(
                  severity: :high,
                  message: "GraphQL field missing authorization check",
                  file: file,
                  line: 1,
                  snippet: "GraphQL resolver without auth",
                  remediation: "Add authorization: authorize @object or Pundit check"
                )
              end
            end
          end
          findings
        end
      end
    end
  end
end
