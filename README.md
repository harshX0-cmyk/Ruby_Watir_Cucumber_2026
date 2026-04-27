# Test Automation Framework – SauceDemo

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

---

## Reporting
    HTML reports are generated at:  
    reports/report.html
---

### Author: Harshith Karpady

