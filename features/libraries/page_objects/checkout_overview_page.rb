class Checkout_Overview_Page
  include Checkout_Overview_Elements

  def initialize(browser)
    @browser = browser
  end

  # Method to verify that the checkout overview page has loaded successfully
  def verify_checkout_overview_page
    checkout_overview_page.wait_until(message: '⚠️ Checkout Overview Page did not load as expected', &:present?)
    puts 'Landed on the Checkout Overview page'
  end

  # Method to verify that the products and total price are displayed correctly on the checkout overview page
  def verify_products_and_total_price
    if products_list.any? && !overview_total_price.text.to_s.strip.empty? && overview_total_price.text.include?('$')
      puts 'Verified products and total price on the checkout overview page'
    else
      raise 'Products or total price not displayed correctly on the checkout overview page'
    end
  end

  # Method to verify that the payment information is displayed correctly on the checkout overview page i.e SauceCard #dddd
  def verify_payment_information
    if payment_info.include?('SauceCard') && payment_info.match?(/#\d+/)
      puts "Verified payment info on the checkout overview page - #{payment_info}"
    else
      raise 'Payment info not displayed correctly on the checkout overview page'
    end
  end

  # Method to verify that the shipping information is displayed correctly on the checkout overview page i.e Free Pony Express Delivery!
  def verify_shipping_information
    if shipping_info.downcase.include?('free pony express delivery')
      puts "Verified shipping info on the checkout overview page - #{shipping_info}"
    else
      raise 'Shipping info not displayed correctly on the checkout overview page'
    end
  end

  # Method to verify that the item total price is displayed correctly on the checkout overview page and matches the expected value based on the items in the cart
  def verify_item_total_price(expected_cart_items)
    if item_total_price_text.to_s.strip.empty? || !item_total_price_text.include?('$')
      raise 'Item total price not displayed correctly on the checkout overview page'
    else
      expected_cart_price = expected_cart_items.map { |item| item[:price].delete('$').to_f }.sum.round(2)
      actual_item_total_price = item_total_price_text.gsub(/[^\d.]/, '').to_f.round(2)
      if actual_item_total_price != expected_cart_price
        raise "Item total price on the checkout overview page does not match expected value - Expected: $#{expected_cart_price}, Actual: $#{actual_item_total_price}"          
      end

      puts "Verified item total price on the checkout overview page - #{actual_item_total_price.round(2)}"
    end
  end

  # Method to verify that the tax price is displayed correctly on the checkout overview page
  def verify_tax_price
    if tax_price.text.to_s.strip.empty? || !tax_price.text.include?('$')
      raise 'Tax price not displayed correctly on the checkout overview page'
    else
      puts "Verified the presence of tax price on the checkout overview page - #{tax_price.text}"
    end
  end

  # Method to verify that the total price after tax is displayed correctly on the checkout overview page and matches the expected value based on the items in the cart and the tax rate
  def verify_total_price_after_tax(expected_cart_items)
    if total_price_after_tax.text.to_s.strip.empty? || !total_price_after_tax.text.include?('$')
      raise 'Total price after tax not displayed correctly on the checkout overview page'
    else
      actual_total_price_after_tax = total_price_after_tax.text.gsub('Total: $', '').to_f
      expected_cart_price = expected_cart_items.map { |item| item[:price].delete('$').to_f }.sum
      expected_tax = (expected_cart_price * 0.08).round(2) # Assuming a tax rate of 8%
      expected_total_price_after_tax = (expected_cart_price + expected_tax).round(2)
      if actual_total_price_after_tax.round(2) != expected_total_price_after_tax.round(2)
        raise "Total price after tax on the checkout overview page does not match expected value - Expected: $#{expected_total_price_after_tax}, Actual: $#{actual_total_price_after_tax}"
      end

      puts "Verified the presence of total price after tax on the checkout overview page - #{total_price_after_tax.text}"
    end
  end

  # Method to click the Finish button to confirm the order and proceed to the order confirmation page
  def click_finish_button
    checkout_overview_page.scroll.to :bottom
    confirm_order_button(checkout_overview_page).click
    puts 'Clicked on the Finish button to confirm the order'
  end

  # Method to click the Cancel button to cancel the checkout process and return to the cart page
  def click_cancel_button
    cancel_button(checkout_overview_page).click
    puts 'Clicked on the Cancel button to cancel the checkout process'
  end
end
