class InventoryPage
  include InventoryElements

  def initialize(browser)
    @browser = browser
  end

  def on_page?
    @browser.url.include?('inventory.html')
  end
end
