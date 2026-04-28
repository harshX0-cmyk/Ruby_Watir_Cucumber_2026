Then('I should see the product inventory for each product') do
  expect(@inventory_page.product_inventory_displayed?).to be(true), 'Expected product inventory to be displayed, but it was not.'
  puts "Product inventory is displayed as expected with #{InventoryPage::EXPECTED_PRODUCT_COUNT} products."
end

When('I add the first product to the cart') do
  @inventory_page.add_first_product_to_cart
end

Then('the product inventory should be updated accordingly') do
  expect(@inventory_page.product_added_to_cart?).to be(true), 'Expected product to be added to cart, but it was not.'
  puts 'Product was successfully added to the cart.'
end

Then('I have added a product to the cart') do
  step 'I add the first product to the cart'
  step 'the product inventory should be updated accordingly'
end

When('I remove the product from the cart') do
  @inventory_page.remove_first_product_from_cart
  puts 'Attempted to remove the product from the cart.'
end

Then('the product inventory should be updated accordingly after removal') do
  expect(@inventory_page.product_removed_from_cart?).to be(true), 'Expected product to be removed from cart, but it was not.'
  puts 'Product was successfully removed from the cart.'
end
