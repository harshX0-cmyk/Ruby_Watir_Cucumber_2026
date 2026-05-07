module Checkout_Overview_Elements
  def checkout_overview_page
    @browser.div(data_test: 'checkout-summary-container')
  end

  def confirm_order_button(parent)
    parent.button(data_test: 'finish')
  end

  def overview_item_names
    @browser.divs(class: 'inventory_item_name')
  end

  def overview_total_price
    @browser.div(data_test: 'total-label')
  end

  def products_list
    overview_item_names.map(&:text)
  end

  def payment_info
    @browser.div(data_test: 'payment-info-value').text
  end

  def shipping_info
    @browser.div(data_test: 'shipping-info-value').text
  end

  def item_total_price_text
    @browser.div(data_test: 'subtotal-label').text
  end

  def tax_price
    @browser.div(data_test: 'tax-label')
  end

  def total_price_after_tax
    @browser.div(data_test: 'total-label')
  end

  def cancel_button(parent)
    parent.button(data_test: 'cancel')
  end
end
