module OurModule

  def register_user

    @driver.find_element(:class, 'register').click
    wait.until {@driver.find_element(:id, 'user_login').displayed?}

    @login = 'omy' + rand(99999).to_s
    @registered_login = @login
    @password = '123123'

    @driver.find_element(:id, 'user_login').send_keys @login
    @driver.find_element(:id, 'user_password').send_keys @password
    @driver.find_element(:id, 'user_password_confirmation').send_keys @password
    @driver.find_element(:id, 'user_firstname').send_keys 'omy'
    @driver.find_element(:id, 'user_lastname').send_keys 'omy'
    @driver.find_element(:id, 'user_mail').send_keys(@login + '@omy.com')
    @driver.find_element(:name, 'commit').click
  end

  def logout
    @logout_button = @driver.find_element(:class, 'logout')
    wait.until {@logout_button.displayed?}
    @logout_button.click
  end

  def login_valid
    @login_button = @driver.find_element(:class, 'login')
    wait.until {@login_button.displayed?}
    @login_button.click
    wait.until {@driver.find_element(:id, 'username').displayed?}
    @driver.find_element(:id, 'username').send_keys @login
    @driver.find_element(:id, 'password').send_keys @password

    @driver.find_element(:name, 'login').click
  end

  def create_project
    @driver.find_element(:class, 'projects').click
    @driver.find_element(:css, '.icon.icon-add').click

    project_name = 'omy_project' + rand(99999).to_s
    project_name_text_field = @driver.find_element(:id, 'project_name')
    wait.until {project_name_text_field.displayed?}
    project_name_text_field.send_keys project_name
    @driver.find_element(:name, 'commit').click
  end

  def create_issue (issue_type)

    if issue_type == 'bug'
      option_value = '1'
    elsif issue_type == 'feature'
      option_value = '2'
    elsif issue_type == 'support'
      option_value = '3'
    end

    @driver.find_element(:class, 'new-issue').click

    issue_type_dropdown = @driver.find_element(:id, 'issue_tracker_id')
    option = Selenium::WebDriver::Support::Select.new(issue_type_dropdown)
    option.select_by(:value, option_value)
    @driver.find_element(:id, 'issue_subject').send_keys 'test'
    @driver.find_element(:name, 'commit').click
  end

  def wait
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end
end
