require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.navigate.to 'http://demo.redmine.org'
  end

  def test_change_password
    register_user
    @driver.find_element(:class, 'icon icon-passwd').click
    @driver.find_element(:id, 'password').send_keys @password
    new_password = '123456'
    @driver.find_element(:id, 'new_password').send_keys new_password
    @driver.find_element(:id, 'new_password_confirmation').send_keys new_password

    #click button <input type="submit" value="Apply" name="commit">
    #<div id="flash_notice" class="flash notice">Password was successfully updated.</div>

  end

  def teardown
    # @driver.quit
  end
end