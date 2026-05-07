class OrderConfirmationPage
  include OrderConfirmationElements
  include RSpec::Matchers

  def initialize(browser)
    @browser = browser
  end

  # Method to verify that the order confirmation page is displayed with the expected message
  def verify_order_confirmation_page
    if order_confirmation_page_container.exists?
      expected_message = 'THANK YOU FOR YOUR ORDER!'
      actual_message = order_confirmation_message
      expect(actual_message).to eq(expected_message)
      puts '✅ Order confirmation page displayed successfully with the correct message.'
    else
      raise '⚠️ Order confirmation page not displayed or missing expected elements.'
    end
  end
end
