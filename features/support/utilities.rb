module Utilities
  # Utility method to take a screenshot and save it with a timestamped filename
  def take_screenshot
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    screenshots_dir = File.join(Dir.pwd, 'screenshots')
    Dir.mkdir(screenshots_dir) unless Dir.exist?(screenshots_dir)
    filepath = File.join(screenshots_dir, "screenshot_#{timestamp}.jpeg")
    @browser.screenshot.save(filepath)
    attach(filepath, 'image/jpeg') if respond_to?(:attach)
    filepath
  end

  # Utility method to wait for the page to load completely before proceeding with further actions
  def wait_for_page_load(timeout = 25)
    Watir::Wait.until(timeout: timeout, message: 'Page did not load in time') do
      @browser.execute_script('return document.readyState') == 'complete'
    end
  end
end

World(Utilities)
