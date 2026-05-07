require 'watir'
require 'pry'
require 'rspec'
require 'cucumber'

#----------------------------------------------------------------------------------------------------
# Watir uses Selenium WebDriver internally.
# Selenium Manager automatically downloads and manages compatible browser drivers.
# No manual driver setup or webdrivers gem is required with Selenium 4.6+.
# Selenium Manager ensures you always have the correct driver version for your browser, simplifying test setup and maintenance.
# For more details, see: https://www.selenium.dev/documentation/webdriver/getting_started/selenium_manager/
# Note: If you have the webdrivers gem installed, it may interfere with Selenium Manager's driver management. It's recommended to remove the webdrivers gem from your Gemfile to avoid conflicts and ensure Selenium Manager can manage drivers effectively.
# require 'webdrivers' # Not needed with Selenium 4.6+ due to Selenium Manager
# Selenium Manager is integrated into Selenium WebDriver starting from version 4.6. This allows Selenium to automatically manage browser drivers without needing the webdrivers gem. If you have the webdrivers gem installed, it may interfere with Selenium Manager's functionality, so it's recommended to remove it from your Gemfile to ensure smooth driver management.
#----------------------------------------------------------------------------------------------------

# Before hook to initialize the browser before each scenario
Before do
  # Initialize browser based on BROWSER environment variable
  begin
    browser_name = ENV['BROWSER'] || 'chrome' # Default to Chrome if BROWSER variable is not set

    browser =
      case browser_name.downcase

      when 'chrome' # CHROME (default)
        options = Selenium::WebDriver::Chrome::Options.new # Configure Chrome browser options

        # Disable password manager services and breach warnings
        options.add_preference('credentials_enable_service', false)
        options.add_preference('profile.password_manager_enabled', false)
        options.add_argument('--disable-features=PasswordLeakDetection')

        # Launch browser in isolated session mode
        options.add_argument('--guest')
        # options.add_argument('--incognito') # Launch browser in incognito mode for clean session isolation

        Watir::Browser.new(:chrome, options: options)

      when 'firefox' # FIREFOX
        Watir::Browser.new(:firefox)

      when 'edge' # EDGE
        Watir::Browser.new(:edge)

      else
        raise "Unsupported browser: #{browser_name}"
      end
    puts "Launched #{browser_name.capitalize} browser successfully"
    browser.window.maximize
    @browser = browser
  rescue StandardError => e
    puts "Error initializing browser: #{e.message}"
    raise # Re-raise exception while preserving original backtrace
  end
end

# AfterStep hook to capture screenshots after each step for debugging and reporting purposes
AfterStep do
  take_screenshot # Capture screenshot after each step for debugging and reporting purposes
end

# After hook to close the browser after each scenario
After do
  @browser.close
end
