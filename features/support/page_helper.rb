module PageHelper
  def login_page
    @login_page ||= LoginPage.new(@browser)
  end

  def inventory_page
    @inventory_page ||= InventoryPage.new(@browser)
  end

  def cart_page
    @cart_page ||= CartPage.new(@browser)
  end

  def checkout_your_information_page
    @checkout_your_information_page ||= Checkout_Your_Information_Page.new(@browser)
  end

  def checkout_overview_page
    @checkout_overview_page ||= Checkout_Overview_Page.new(@browser)
  end

  def order_confirmation_page
    @order_confirmation_page ||= OrderConfirmationPage.new(@browser)
  end
end

World(PageHelper)
