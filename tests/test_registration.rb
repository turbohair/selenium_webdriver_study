require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to 'http://demo.redmine.org'
  end


  def test_positive
    register_user
    expected_text = 'Your account has been activated. You can now log in.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  # def test_log_out
  #   register_user
  #   @driver.find_element(:class, 'logout').click
  #   sleep 3
  #   login_button = @driver.find_element(:class, 'login')
  #   assert(login_button.displayed?)
  #
  # end

  def teardown
    @driver.quit
  end
end