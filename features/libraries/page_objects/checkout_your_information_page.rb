class Checkout_Your_Information_Page
  include CheckoutYourInformationElements

  def initialize(browser)
    @browser = browser
  end

  # Method to verify that the checkout page has loaded successfully
  def verify_checkout_page
    checkout_your_information_page.wait_until(message: '⚠️ Checkout Page did not load as expected', &:present?)
    puts 'Verified checkout page'
  end

  # Method to fill in the checkout information
  def fill_checkout_information(first_name, last_name, zip_code)
    checkout_first_name_field.set(first_name)
    checkout_last_name_field.set(last_name)
    checkout_zip_code_field.set(zip_code)
    puts "Filled in checkout information: First Name - #{first_name}, Last Name - #{last_name}, Zip Code - #{zip_code}"
  end

  # Method to click on the continue button to proceed to the next step of checkout
  def click_continue_button
    checkout_continue_button.click
    puts 'Clicked on the Continue button to proceed to the next step of checkout'
  end
end
