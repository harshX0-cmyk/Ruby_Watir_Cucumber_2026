# Test Automation Framework - SauceDemo

This project is a BDD test automation framework built using:

- Ruby
- Watir
- Cucumber
- RSpec

---

## Project Overview

The framework automates key user flows on https://www.saucedemo.com/ including:

- Login functionality
- Product inventory validation
- Add to cart and remove items
- Checkout process
- Negative scenarios (invalid login, locked user)

---

## Framework Design
- Page Object Model (POM)
- Data-driven approach using centralized credentials
- Cucumber BDD structure
- Separation of concerns:
  - Page classes: actions and state
  - Step definitions: assertions
  - Feature files: business scenarios
  - Modules: reusable components shared across pages
---

## Project Structure
- features/*.feature
- step_definitions/
- support/
- pages/
- modules/
- reports/
- cucumber.yml
- Gemfile
- README.md

---
## Setup Instructions
### Install Ruby
    ruby -v
### Install dependencies
    bundle install
---

## Running Tests
   ### Run specific tag
    cucumber -t @valid_login

## Browser Support

The framework supports cross-browser execution on:

- Chrome
- Firefox
- Microsoft Edge

Examples:

```
cucumber BROWSER=chrome -t @valid_login

cucumber BROWSER=firefox -t @valid_login

cucumber BROWSER=edge -t @valid_login
```
---

## Reporting
- HTML reports are generated at:  
 `reports/report.html`
---

## GitHub Actions CI/CD Integration

The framework is integrated with GitHub Actions for automated cloud execution.

Workflow execution flow:

1. Push code changes to GitHub
2. GitHub Actions creates a temporary Windows runner environment
3. Repository source code is downloaded to the runner
4. Latest Ruby version is installed automatically
5. Required gems are installed using Bundler
6. Cucumber test scenarios are executed based on tags
7. HTML execution reports are generated
8. Reports are uploaded as downloadable GitHub Actions artifacts

The workflow currently supports separate execution jobs for:

- @sanity
- @smoke
- @regression

GitHub Actions workflow configuration:

```text
.github/workflows/cucumber.yml
```
### Author: Harshith Karpady :)

