Then('I should see the product inventory for each product') do
  expect(inventory_page.product_inventory_displayed?).to be(true), 'Expected product inventory to be displayed, but it was not.'
  puts "Product inventory is displayed as expected with #{InventoryPage::EXPECTED_PRODUCT_COUNT} products."
end

And('I add {int} product(s) to the cart') do |int|
  @expected_cart_items = []
  int.times do |index|
    selected_product = inventory_page.inventory_items[index]
    selected_product.button(text: /Add to cart/i).flash(flashes: 1, delay: 0.05).click!
    @expected_cart_items = inventory_page.record_cart_item(selected_product)
    puts "Added product #{index + 1} - #{@expected_cart_items.last[:name]} to the cart"
  end
  puts "Added #{@expected_cart_items.size} items in cart"
end

Then('the product inventory should be updated accordingly') do
  expect(inventory_page.product_added_to_cart?).to be(true), 'Expected product to be added to cart, but it was not.'
  puts 'Product was successfully added to the cart.'
end

Then('I verify if I added a product to the cart') do
  step 'I add a product to the cart'
  step 'the product inventory should be updated accordingly'
end

When('I remove the product from the cart') do
  inventory_page.remove_first_product_from_cart
  puts 'Attempted to remove the product from the cart.'
end

Then('the product inventory should be updated accordingly after removal') do
  expect(inventory_page.product_removed_from_cart?).to be(true), 'Expected product to be removed from cart, but it was not.'
  puts 'Product was successfully removed from the cart.'
end

Then('the cart badge count should be {int}') do |int|
  Watir::Wait.until(timeout: 15) { inventory_page.cart_count == int }
  expect(inventory_page.cart_count).to eq(int), "Expected cart badge count to be #{int}, but it was #{inventory_page.cart_count}."
  puts "Cart badge count is correctly updated to #{int}."
end

When('I add the product again') do
  inventory_page.add_product_to_cart
  puts 'Attempted to add the product again to the cart.'
end

Then('I should be redirected back to the inventory page and the cart should remain unchanged') do ||
  inventory_page.verify_inventory_page_displayed
  expect(inventory_page.cart_count).to eq(@expected_cart_items.size), "Expected cart badge count to remain unchanged at #{@expected_cart_items.size}, but it was #{inventory_page.cart_count}."
  puts 'Successfully navigated back to the inventory page and the cart badge count remains unchanged.'
end
