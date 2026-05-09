@login
Feature: I am trying to the website https://www.saucedemo.com/ with valid credentials

  @valid_login @regression @smoke @sanity
  Scenario: I am trying to login with valid credentials
    Given I am on the login page
    When I login to the website with "valid credentials"
    Then I should be logged in successfully
    And I should see the inventory page

  @invalid_login_username
  Scenario: I am trying to login with an invalid username
    Given I am on the login page
    When I login to the website with "invalid username" 
    Then I should see an error message indicating invalid credentials

  @invalid_login_password
  Scenario: I am trying to login with an invalid password
    Given I am on the login page
    When I login to the website with "invalid password"
    Then I should see an error message indicating invalid credentials

  @invalid_login_both
  Scenario: I am trying to login with invalid credentials
    Given I am on the login page
    When I login to the website with "invalid"
    Then I should see an error message indicating invalid credentials

  @locked_out_user
  Scenario: I am trying to login with a locked out user
    Given I am on the login page
    When I login to the website with "locked" 
    Then I should see an error message indicating the user is locked out