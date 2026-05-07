class InventoryPage
  include InventoryElements
  include RSpec::Matchers

  EXPECTED_PRODUCT_COUNT = 6
  INVENTORY_PATH = 'inventory.html'
  EXPECTED_PAGE_TITLE = 'Swag Labs'

  def initialize(browser)
    @browser = browser
  end

  # Waits until the inventory page is fully loaded by checking the URL and page title, raising an error if the expected page is not loaded within the timeout period.
  def on_page?
    begin
      Watir::Wait.until(timeout: 20) { inventory_url? && products_title? }
    rescue Watir::Wait::TimeoutError
      raise "Expected to be on the inventory page '#{INVENTORY_PATH}', but the actual page is #{@browser.url}"
    end
  end
  alias verify_inventory_page_displayed on_page?

  # private

  def inventory_url?
    @browser.url.include?(INVENTORY_PATH)
  end

  def products_title?
    @browser.title == EXPECTED_PAGE_TITLE
  end

  # Verifies that the inventory page displays the expected number of products with their names and prices.
  def product_inventory_displayed?
    inventory_items.size == EXPECTED_PRODUCT_COUNT &&
      inventory_item_names.all?(&:present?) &&
      inventory_item_prices.all?(&:present?)
  end

  # Clicks the "Add to cart" button for the first product and waits for the cart to update.
  def add_product_to_cart
    raise 'No Add to cart buttons found on inventory page' if add_to_cart_buttons.empty?

    add_to_cart_buttons.first.flash(flashes: 1, delay: 0.05).click!
    puts "Clicked 'Add to cart' button for a product. Waiting for the cart to update..."
  end

  # Removes the first product from the cart by clicking the "Remove" button and waits for the cart to update.
  def remove_first_product_from_cart
    raise 'No Remove buttons found on inventory page' if remove_buttons.empty?

    remove_buttons.first.flash(flashes: 1, delay: 0.05).click
    puts "Clicked 'Remove' for the first product. Waiting for the cart to update..."
  end

  def cart_count
    return 0 unless shopping_cart_badge.present?

    shopping_cart_badge.text.to_i
  end

  # Checks if the product was successfully added to the cart by verifying that the cart count is 1 and the "Remove" buttons are present.
  def product_added_to_cart?
    wait_time = 15
    begin
      Watir::Wait.until(timeout: wait_time) { cart_count == 1 && remove_buttons.any?(&:present?) }
      return true
    rescue StandardError
      return false
    end
    puts "Cart count after adding product: #{cart_count}. Remove button present: #{remove_buttons.any?(&:present?)}"
  end

  # Checks if the product was successfully removed from the cart by verifying that the cart count is zero and the "Add to cart" buttons are present again.
  def product_removed_from_cart?
    wait_time = 15
    begin
      Watir::Wait.until(timeout: wait_time) { cart_count.zero? && add_to_cart_buttons.any?(&:present?) }
      return true
    rescue StandardError
      return false
    end
    puts "Cart count after removing product: #{cart_count}. Add to cart button present: #{add_to_cart_buttons.any?(&:present?)}"
  end

  # Records the details of a product added to the cart, including name, price, and quantity.
  def record_cart_item(product)
    @cart_items ||= []

    product_name = product.element(class: 'inventory_item_name').text
    product_price = product.element(class: 'inventory_item_price').text

    existing_item = @cart_items.find do |item|
      item[:name] == product_name
    end

    if existing_item
      existing_item[:quantity] += 1
    else
      @cart_items << {
        name: product_name,
        price: product_price,
        quantity: 1
      }
    end
  end
end
