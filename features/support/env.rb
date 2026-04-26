require 'watir'
require 'webdrivers'
require 'pry'
require 'rspec'
require 'cucumber'

Before do |scenario|
  browser = Watir::Browser.new
  @browser = browser
end

After do |scenario|
  @browser.close
end

at_exit do
  Webdrivers::Chromedriver.update
  # @browser.quit
end 