module OurModule
  def register_user

    @driver.find_element(:class, 'register').click
    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    @login = 'omy' + rand(99999).to_s
    @registered_login = @login
    @password = '123123'

    @driver.find_element(:id, 'user_login').send_keys @login
    @driver.find_element(:id, 'user_password').send_keys @password
    @driver.find_element(:id, 'user_password_confirmation').send_keys @password
    @driver.find_element(:id, 'user_firstname').send_keys 'asdfqwe'
    @driver.find_element(:id, 'user_lastname').send_keys 'asdfqwe'
    @driver.find_element(:id, 'user_mail').send_keys(@login + '@omy.com')
    @driver.find_element(:name, 'commit').click
  end

  def logout
    @logout_button = @driver.find_element(:class, 'logout')
    @wait.until {@logout_button.displayed?}
    @logout_button.click
  end

  def login_valid
    @login_button = @driver.find_element(:class, 'login')
    @wait.until {@login_button.displayed?}
    @login_button.click
    sleep 10
    @driver.find_element(:id, 'username').send_keys @login
    @driver.find_element(:id, 'password').send_keys @password

    @driver.find_element(:name, 'login').click

  end
end
