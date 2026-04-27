module LoginElements
  def username
    @browser.text_field(id: 'user-name')
  end

  def password
    @browser.text_field(id: 'password')
  end

  def login_button
    @browser.button(id: 'login-button')
  end
end
