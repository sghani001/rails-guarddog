# Rails GuardDog 🐕

Advanced security scanning for Rails applications. Beyond brakeman — AI injection, DoS patterns, supply chain attacks, GraphQL auth, and more.

## Features

### Core Checks
- SQL Injection (improved detection)
- XSS in views
- CSRF protection
- Mass assignment vulnerabilities
- Open redirects
- Hardcoded secrets (always-on)

### Original Features ⭐
- **AI/LLM Prompt Injection** — Detects user input flowing into LLM calls
- **DoS & ReDoS Detection** — Regex catastrophe and unbounded query patterns
- **Supply Chain** — Typosquatting detection with Levenshtein distance
- **GraphQL Auth Gaps** — Missing field-level authorization
- **Rate Limiting Audit** — Checks rack-attack configuration

## Installation

Add to Gemfile:
```ruby
gem 'rails-guarddog'
```

Run:
```bash
bundle install
```

## Usage

### CLI
```bash
guarddog scan      # Console output
guarddog report    # HTML + JSON reports
```

### Rake Tasks
```bash
rake guarddog:scan      # Run scan
rake guarddog:report    # Generate reports
rake guarddog:ci        # CI integration (exits 1 on critical)
```

## Report Formats

- **Console** — Color-coded terminal output
- **HTML** — Interactive dashboard with filtering
- **JSON** — Structured format for CI/CD integration

## Configuration

Create `config/initializers/guarddog.rb`:
```ruby
Rails.application.config.guarddog.enabled_checkers = %w[
  sql_injection xss csrf mass_assignment
]
```

## License

MIT
