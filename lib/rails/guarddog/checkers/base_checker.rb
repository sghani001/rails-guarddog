module Rails
  module Guarddog
    module Checkers
      class BaseChecker
        attr_accessor :findings

        def initialize(root = Rails.root.to_s)
          @root = root
          @findings = []
        end

        def run
          raise NotImplementedError, "Subclasses must implement run"
        end

        protected

        def add_finding(severity:, message:, file:, line:, snippet: "", remediation: "")
          findings << Finding.new(
            severity: severity,
            category: self.class.name.demodulize.gsub(/Checker$/, ''),
            message: message,
            file: file,
            line: line,
            code_snippet: snippet,
            remediation: remediation
          )
        end

        def glob_files(pattern)
          Dir.glob(File.join(@root, pattern))
        end
      end
    end
  end
end
