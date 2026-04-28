module InventoryElements
  def inventory_list
    @browser.divs(class: 'inventory_item')
  end

  def add_to_cart_buttons
    @browser.buttons(class: 'btn_primary')
    # @browser.buttons(text: /Add to cart/)
  end

  def inventory_items
    @browser.divs(class: 'inventory_item')
  end

  def inventory_item_names
    @browser.divs(class: 'inventory_item_name')
  end

  def inventory_item_prices
    @browser.divs(class: 'inventory_item_price')
  end

  def remove_buttons
    @browser.buttons(text: /Remove/)
  end

  def shopping_cart_badge
    @browser.span(class: 'shopping_cart_badge')
  end
end
