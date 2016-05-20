require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to 'http://demo.redmine.org'
  end

  def test_create_project
    register_user
    create_project

    wait.until {@driver.find_element(:id, 'flash_notice').displayed?}

    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    @driver.quit
  end
end
