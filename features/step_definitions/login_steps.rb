Given('I am on the login page') do
  login_page.load_url 'https://www.saucedemo.com'
  login_page.on_page?
end

When('I login to the website with {string}') do |user_type|
  username, password = login_page.credentials_for(user_type)
  login_page.login_with_credentials(username, password)
end

Then('I should be logged in successfully') do
  login_page.logged_in?
end

Then('I should see the inventory page') do
  expect(inventory_page.on_page?).to be(true), "Error: Expected to be on the inventory page, but the actual page is #{@browser.url}"
  puts "Successfully navigated to the inventory page: #{@browser.url}"
end

Then('I should see an error message indicating invalid credentials') do
  error_message = login_page.login_error_message
  expect(error_message).to be_present, 'Expected an error message to be displayed, but it was not found.'
  expect(error_message.text.downcase).to include('username and password do not match any user in this service')
  puts "Error message displayed as expected: #{error_message.text}"
end

Then('I should see an error message indicating the user is locked out') do
  error_message = login_page.login_error_message
  expect(error_message).to be_present, 'Expected an error message to be displayed, but it was not found.'
  expect(error_message.text.downcase).to include('sorry, this user has been locked out')
  puts "Error message displayed as expected: #{error_message.text}"
end
