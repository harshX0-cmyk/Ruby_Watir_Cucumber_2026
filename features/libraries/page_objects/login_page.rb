class LoginPage
  include LoginElements
  include RSpec::Matchers

  def initialize(browser)
    @browser = browser
  end

  def load_url(url)
    @browser.goto url
  end

  def on_page?
    username.wait_until(&:present?)
  end

  CREDENTIALS = {
    'valid credentials' => %w[standard_user secret_sauce],
    'invalid username' => %w[invalid_user secret_sauce],
    'invalid password' => %w[standard_user wrong_pass],
    'invalid' => %w[invalid_user wrong_pass],
    'locked' => %w[locked_out_user secret_sauce]
  }

  def credentials_for(user_type)
    creds = CREDENTIALS[user_type]
    raise "Unknown user type: #{user_type}" unless creds

    creds
  end

  def login_with_credentials(username, password)
    self.username.set username
    self.password.set password
    login_button.flash(:fast).click
  end

  def logged_in?
    Watir::Wait.until(timeout: 10) { @browser.url.include?('inventory') }
    expect(@browser.title).to eq('Swag Labs')
  end

  def login_error_message
    @browser.div(class: 'error-message-container').wait_until(&:present?)
  end
end
