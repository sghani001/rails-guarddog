module Rails
  module Guarddog
    class Finding
      attr_accessor :severity, :category, :message, :file, :line, :code_snippet, :remediation

      def initialize(severity:, category:, message:, file:, line:, code_snippet: "", remediation: "")
        @severity = severity
        @category = category
        @message = message
        @file = file
        @line = line
        @code_snippet = code_snippet
        @remediation = remediation
      end

      def to_h
        {
          severity: severity,
          category: category,
          message: message,
          file: file,
          line: line,
          code_snippet: code_snippet,
          remediation: remediation
        }
      end
    end
  end
end
