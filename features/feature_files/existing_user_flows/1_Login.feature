Feature: I am trying to the website https://www.saucedemo.com/ with valid credentials

@login
  Scenario: I am trying to login with valid credentials
    Given I am on the login page
    When I login to the website with valid credentials "standard_user" and "secret_sauce"
    Then I should be logged in successfully 