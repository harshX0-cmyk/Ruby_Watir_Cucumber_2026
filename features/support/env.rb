require 'watir'
require 'webdrivers'
require 'pry'
require 'rspec'
require 'cucumber'

Before do
  @browser = Watir::Browser.new :chrome
end

After do
  @browser.close
end