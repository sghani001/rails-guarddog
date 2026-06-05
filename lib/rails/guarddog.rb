require 'rails'
require_relative 'guarddog/version'
require_relative 'guarddog/configuration'
require_relative 'guarddog/finding'
require_relative 'guarddog/scanner'
require_relative 'guarddog/checkers/base_checker'
require_relative 'guarddog/checkers/sql_injection_checker'
require_relative 'guarddog/checkers/xss_checker'
require_relative 'guarddog/checkers/csrf_checker'
require_relative 'guarddog/checkers/mass_assignment_checker'
require_relative 'guarddog/checkers/open_redirect_checker'
require_relative 'guarddog/checkers/secrets_checker'
require_relative 'guarddog/checkers/dos_checker'
require_relative 'guarddog/checkers/idor_checker'
require_relative 'guarddog/checkers/ai_injection_checker'
require_relative 'guarddog/checkers/rate_limit_checker'
require_relative 'guarddog/checkers/dependency_checker'
require_relative 'guarddog/checkers/graphql_checker'
require_relative 'guarddog/reporters/console_reporter'
require_relative 'guarddog/reporters/json_reporter'
require_relative 'guarddog/reporters/html_reporter'
require_relative 'guarddog/railtie'

module Rails
  module Guarddog
  end
end
