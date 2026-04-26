Given('I am on the login page') do
  @login_page = LoginPage.new(@browser)
  @login_page.load_url "https://www.saucedemo.com"
end

When('I login to the website with valid credentials {string} and {string}') do |username, password|
  @login_page.login_with_credentials(username, password)
end

Then('I should be logged in successfully') do
  expect(@login_page.logged_in?).to be true
end
