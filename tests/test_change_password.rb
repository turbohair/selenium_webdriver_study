require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to 'http://demo.redmine.org'
  end

  def test_change_password
    register_user
    @driver.find_element(:css, '.icon.icon-passwd').click
    @driver.find_element(:id, 'password').send_keys @password
    new_password = '123456'
    @driver.find_element(:id, 'new_password').send_keys new_password
    @driver.find_element(:id, 'new_password_confirmation').send_keys new_password
    @driver.find_element(:name, 'commit').click

    expected_text = 'Password was successfully updated.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    @driver.quit
  end
end