module Rails
  module Guarddog
    module Checkers
      class AiInjectionChecker < BaseChecker
        AI_GEMS = %w[ruby-openai anthropic langchainrb openai]
        
        def run
          glob_files('app/**/*.rb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              # Check for AI gem calls with user input
              if line.match?(/\.create.*messages/) || line.match?(/\.chat\.completions/)
                if line.include?('params') || line.include?('user_input')
                  add_finding(
                    severity: :critical,
                    message: "AI prompt injection risk: user input passed to LLM without sanitization",
                    file: file,
                    line: idx + 1,
                    snippet: line.strip,
                    remediation: "Sanitize user input before passing to LLM; use system prompts safely"
                  )
                end
              end
            end
          end
          findings
        end
      end
    end
  end
end
