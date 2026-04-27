module InventoryElements
  def inventory_list
    @browser.divs(class: 'inventory_item')
  end

  def add_to_cart_buttons
    @browser.buttons(class: 'btn_primary')
  end
end
