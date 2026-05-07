module CartElements
  def cart_icon
    @browser.link('data-test': 'shopping-cart-link')
  end

  def cart_page
    @browser.div(data_test: 'cart-contents-container')
  end

  def checkout_page
    @browser.div(data_test: 'checkout-info-container')
  end

  def cart_items
    @browser.divs(class: 'cart_item')
  end

  def cart_item_name(parent)
    parent.div(class: 'inventory_item_name')
  end

  def cart_item_quantity(parent)
    parent.div(data_test: 'item-quantity')
  end

  def cart_item_price(parent)
    parent.div(class: 'inventory_item_price')
  end

  def checkout_button
    @browser.button(data_test: 'checkout')
  end
end
