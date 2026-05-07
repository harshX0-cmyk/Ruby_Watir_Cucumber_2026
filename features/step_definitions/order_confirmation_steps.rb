Then('I should see a confirmation message for successful checkout') do
  binding.pry
  order_confirmation_page.verify_order_confirmation_page
end
