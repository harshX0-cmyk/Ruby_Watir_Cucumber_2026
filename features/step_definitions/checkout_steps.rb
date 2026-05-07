When('I fill in the checkout information') do
  checkout_your_information_page.fill_checkout_information('John', 'Doe', '12345')
end

When('I click on the continue button to proceed to the next step of checkout') do
  checkout_your_information_page.click_continue_button
end

Then('I should see the Checkout Overview page with the correct products and total price') do
  checkout_overview_page.verify_checkout_overview_page
  wait_for_page_load
  checkout_overview_page.verify_products_and_total_price
end

Then('I confirm the order') do
  checkout_overview_page.click_finish_button
end

When('I decide to cancel the checkout process') do
  checkout_overview_page.click_cancel_button
  wait_for_page_load
  inventory_page.verify_inventory_page_displayed
  puts '✅ Successfully navigated back to the inventory page after cancelling checkout.'
end

Then('I should be able to see the total price including taxes before confirming the order') do ||
  checkout_overview_page.verify_item_total_price(@expected_cart_items)
  checkout_overview_page.verify_tax_price
  checkout_overview_page.verify_total_price_after_tax(@expected_cart_items)
  puts '✅ Verified that the total price including taxes is displayed correctly on the checkout overview page before confirming the order.'
end

Then('I should be able to see the payment and shipping information on the checkout overview page') do ||
  checkout_overview_page.verify_payment_information
  checkout_overview_page.verify_shipping_information
  puts '✅ Verified that the payment and shipping information is displayed correctly on the checkout overview page.'
end
