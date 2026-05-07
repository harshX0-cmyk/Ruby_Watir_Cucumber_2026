module OrderConfirmationElements
  def order_confirmation_page_container
    @browser.div(id: 'checkout_complete_container')
  end

  def order_confirmation_message
    order_confirmation_page_container.h2.text.strip.upcase
  end
end
