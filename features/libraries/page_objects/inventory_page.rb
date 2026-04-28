class InventoryPage
  include InventoryElements
  include RSpec::Matchers

  EXPECTED_PRODUCT_COUNT = 6
  INVENTORY_PATH = 'inventory.html'
  EXPECTED_PAGE_TITLE = 'Swag Labs'

  def initialize(browser)
    @browser = browser
  end

  def on_page?
    begin
      Watir::Wait.until(timeout: 20) { inventory_url? && products_title? }
    rescue Watir::Wait::TimeoutError
      raise "Expected to be on the inventory page '#{INVENTORY_PATH}', but the actual page is #{@browser.url}"
    end
  end

  # private

  def inventory_url?
    @browser.url.include?(INVENTORY_PATH)
  end

  def products_title?
    @browser.title == EXPECTED_PAGE_TITLE
  end

  def product_inventory_displayed?
    inventory_items.size == EXPECTED_PRODUCT_COUNT &&
      inventory_item_names.all?(&:present?) &&
      inventory_item_prices.all?(&:present?)
  end

  def add_first_product_to_cart
    raise 'No Add to cart buttons found on inventory page' if add_to_cart_buttons.empty?

    add_to_cart_buttons.first.flash(:fast).click!
    puts "Clicked 'Add to cart' for the first product. Waiting for the cart to update..."
  end

  def remove_first_product_from_cart
    raise 'No Remove buttons found on inventory page' if remove_buttons.empty?

    remove_buttons.first.flash(:fast).click
    puts "Clicked 'Remove' for the first product. Waiting for the cart to update..."
  end

  def cart_count
    return 0 unless shopping_cart_badge.present?

    shopping_cart_badge.text.to_i
  end

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
end
