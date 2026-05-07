module CheckoutYourInformationElements
  def checkout_your_information_page
    @browser.div(data_test: 'checkout-info-container')
  end

  def checkout_first_name_field
    @browser.text_field(id: 'first-name')
  end

  def checkout_last_name_field
    @browser.text_field(id: 'last-name')
  end

  def checkout_zip_code_field
    @browser.text_field(id: 'postal-code')
  end

  def checkout_continue_button
    @browser.button(data_test: 'continue')
  end
end
