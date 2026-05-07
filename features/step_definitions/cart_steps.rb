When('I proceed to cart by clicking on the cart icon') do
  cart_page.click_cart_icon
  cart_page.verify_cart_page
end

Then('the cart should display the correct product details') do
  actual_cart_item = cart_page.fetch_cart_item_details
  expect(actual_cart_item).to eq(@expected_cart_item)
end

When('I proceed to checkout') do
  cart_page.click_checkout_button
  checkout_your_information_page.verify_checkout_page
end

When('I verify the products on the cart page with the values earlier on the inventory page') do
  # Compare the cart items count and print a message confirming the verification
  actual_cart_items = cart_page.fetch_cart_items_details
  expect(actual_cart_items).to eq(@expected_cart_items)
  puts "Verified cart items match expected values - #{actual_cart_items.size} items in cart."
  # Compare the actual cart items with the expected cart items and print a message confirming the verification
  # mismatch_items = []
  # actual_cart_items.each_with_index do |item, index|
  #   expected_item = @expected_cart_items[index]
  #   if item == expected_item
  #     puts "Cart item #{index + 1} - #{item[:name]} matches expected values."
  #   else
  #     puts "Cart item #{index + 1} - #{item[:name]} does NOT match expected values."
  #     mismatch_items << item
  #   end
  # end
  # mismatch_items_names = mismatch_items.map { |item| item[:name] }.join(', ')
  # if mismatch_items.empty?
  #   puts 'All cart items match expected values.'
  # else
  #   puts "There are #{mismatch_items.size} mismatched items in the cart - #{mismatch_items_names}"
  # end
end
