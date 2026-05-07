@checkout_process
Feature: Checkout Process for the user on https://www.saucedemo.com/

  Background:
    Given I am on the login page
    When I login to the website with "valid credentials"
    Then I should be logged in successfully
    And I should see the inventory page

  @successful_checkout
  Scenario: User can complete the checkout process successfully
    And I add 2 products to the cart
    And I proceed to cart by clicking on the cart icon
    And I verify the products on the cart page with the values earlier on the inventory page
    And I proceed to checkout
    And I fill in the checkout information
    When I click on the continue button to proceed to the next step of checkout
    Then I should see the Checkout Overview page with the correct products and total price
    And I confirm the order
    Then I should see a confirmation message for successful checkout

  @checkout_cancellation
  Scenario: User can cancel the checkout process
    When I add 1 product to the cart
    And I proceed to cart by clicking on the cart icon
    And I proceed to checkout
    And I fill in the checkout information
    When I click on the continue button to proceed to the next step of checkout
    Then I should see the Checkout Overview page with the correct products and total price
    And I decide to cancel the checkout process
    Then I should be redirected back to the inventory page and the cart should remain unchanged

  @checkout_total_price_verification
  Scenario: User can see the total price including taxes before confirming the order
    When I add 1 product to the cart
    And I proceed to cart by clicking on the cart icon
    And I proceed to checkout
    And I fill in the checkout information
    When I click on the continue button to proceed to the next step of checkout
    Then I should see the Checkout Overview page with the correct products and total price
    Then I should be able to see the total price including taxes before confirming the order

  @checkout_payment_and_shipping_validation
  Scenario: User can see the payment and shipping information on the checkout overview page
    When I add 1 product to the cart
    And I proceed to cart by clicking on the cart icon
    And I proceed to checkout
    And I fill in the checkout information
    When I click on the continue button to proceed to the next step of checkout
    Then I should see the Checkout Overview page with the correct products and total price
    Then I should be able to see the payment and shipping information on the checkout overview page

  @checkout_multiple_products
  Scenario: User can complete the checkout process with multiple products in the cart
    When I add 6 products to the cart
    And I proceed to cart by clicking on the cart icon
    And I proceed to checkout
    And I fill in the checkout information
    When I click on the continue button to proceed to the next step of checkout
    And I confirm the order
    Then I should see a confirmation message for successful checkout
