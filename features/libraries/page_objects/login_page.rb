class LoginPage
  include Login

  def initialize(browser)
    @browser = browser
  end

  def load_url(url)
    @browser.goto url
  end

  def login_with_credentials(username, password)
    self.username.set username
    self.password.set password
    self.login_button.flash(:fast).click
  end

  def logged_in?
    @browser.url.include?("inventory")
  end
end