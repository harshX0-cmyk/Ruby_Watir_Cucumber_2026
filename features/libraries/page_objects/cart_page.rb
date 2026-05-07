class CartPage
  include CartElements

  def initialize(browser)
    @browser = browser
  end

  def click_cart_icon
    cart_icon.click
    puts 'Clicked on cart icon'
  end

  def verify_cart_page
    cart_page.wait_until(message: '⚠️ Cart Page did not load as expected', &:present?)
    puts 'Verified cart page'
  end

  def click_checkout_button
    checkout_button.click
    puts 'Clicked on checkout button'
  end

  # Fetches the details of all cart items and returns them as an array of hashes
  def fetch_cart_items_details
    cart_items.map do |item|
      item.wait_until(&:present?)
      {
        name: cart_item_name(item).text,
        price: cart_item_price(item).text,
        quantity: cart_item_quantity(item).text.to_i
      }
    end
  end
end
