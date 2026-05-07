class LoginPage
  include LoginElements
  include RSpec::Matchers

  def initialize(browser)
    @browser = browser
  end

  def load_url(url)
    @browser.goto url
  end

  # Waits until the login page is fully loaded by checking for the presence of the username field.
  def on_page?
    username.wait_until(message: '⚠️ Login Page did not load as expected', &:present?)
  end

  # Provides a hash of predefined credentials for different user types, including valid and invalid combinations.
  CREDENTIALS = {
    'valid credentials' => %w[standard_user secret_sauce],
    'invalid username' => %w[invalid_user secret_sauce],
    'invalid password' => %w[standard_user wrong_pass],
    'invalid' => %w[invalid_user wrong_pass],
    'locked' => %w[locked_out_user secret_sauce]
  }

  # Retrieves the username and password for a given user type from the CREDENTIALS hash, raising an error if the user type is unknown.
  def credentials_for(user_type)
    creds = CREDENTIALS[user_type]
    raise "Unknown user type: #{user_type}" unless creds

    creds
  end

  # Logs in using the provided username and password by filling in the respective fields and clicking the login button.
  def login_with_credentials(username, password)
    self.username.set username
    self.password.set password
    login_button.flash(flashes: 1, delay: 0.05).click
  end

  # Verifies that the login was successful by waiting for the URL to include 'inventory' and checking that the page title is 'Swag Labs'.
  def logged_in?
    Watir::Wait.until(timeout: 10) { @browser.url.include?('inventory') }
    expect(@browser.title).to eq('Swag Labs')
  end

  # Verifies that the appropriate error message is displayed for failed login attempts by checking the text of the error message container.
  def login_error_message
    @browser.div(class: 'error-message-container').wait_until(message: '⚠️Login error message did not appear as expected', &:present?)
  end
end
