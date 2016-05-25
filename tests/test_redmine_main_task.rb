require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRedmineMainTask < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to 'http://demo.redmine.org'
  end

  def test_registration_positive
    register_user
    assert(@driver.find_element(:id, 'flash_notice').displayed?)
  end

  def test_logout
    register_user
    logout
    assert(@driver.find_element(:class, 'login').displayed?)
  end

  def test_login_positive
    register_user
    logout
    login_valid
    assert(@driver.find_element(:class, 'logout').displayed?)
  end

  def test_change_password
    register_user
    @driver.find_element(:css, '.icon.icon-passwd').click
    @driver.find_element(:id, 'password').send_keys @password
    new_password = '123456'
    @driver.find_element(:id, 'new_password').send_keys new_password
    @driver.find_element(:id, 'new_password_confirmation').send_keys new_password
    @driver.find_element(:name, 'commit').click

    assert(@driver.find_element(:id, 'flash_notice').displayed?)
  end

  def test_create_project
    register_user
    create_project

    # wait.until {@driver.find_element(:id, 'flash_notice').displayed?}

    assert(@driver.find_element(:id, 'flash_notice').displayed?)
  end

  def test_create_project_version
    register_user
    create_project
    @driver.find_element(:id, 'tab-versions').click

    new_version_button = @driver.find_element(:css, '#tab-content-versions .icon.icon-add')
    new_version_button.click

    wait.until {@driver.find_element(:id, 'version_name').displayed?}
    @driver.find_element(:id, 'version_name').send_keys 'omy_version'
    @driver.find_element(:name, 'commit').click

    assert(@driver.find_element(:id, 'flash_notice').displayed?)
  end

  def test_create_issue_type_bug
    register_user
    create_project
    create_issue('bug')
    assert(issue_type_header = @driver.find_element(:css, 'h2').text.include?('Bug'))
  end

  def test_create_issue_type_feature
    register_user
    create_project
    create_issue('feature')
    assert(issue_type_header = @driver.find_element(:css, 'h2').text.include?('Feature'))
  end

  def test_create_issue_type_support
    register_user
    create_project
    create_issue('support')
    assert(issue_type_header = @driver.find_element(:css, 'h2').text.include?('Support'))
  end

  def teardown
    @driver.quit
  end
end
