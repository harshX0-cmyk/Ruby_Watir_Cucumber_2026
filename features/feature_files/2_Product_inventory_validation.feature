@inventory_validation
Feature: Product Inventory Validation on https://www.saucedemo.com

  Background:
    Given I am on the login page
    When I login to the website with "valid credentials"
    Then I should be logged in successfully
    And I should see the inventory page

  @inventory_for_each_product
  Scenario: Verify that the product inventory is displayed correctly on the products page
    Then I should see the product inventory for each product

  @inventory_add_to_cart
  Scenario: Verify that the product inventory is updated correctly after adding a product to the cart
    When I add 1 product to the cart
    Then the product inventory should be updated accordingly

  @inventory_remove_from_cart
  Scenario: Verify that the product inventory is updated correctly after removing a product from the cart
    And I verify if I added a product to the cart
    When I remove the product from the cart
    Then the product inventory should be updated accordingly after removal

  @cart_quantity
  Scenario: Verify cart badge count updates when products are added
    When I add 2 products to the cart
    Then the cart badge count should be 2

  @remove_and_re_add
  Scenario: Verify user can remove and re-add a product
    And I verify if I added a product to the cart
    When I remove the product from the cart
    And I add the product again
    Then the cart badge count should be 1
