require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to 'http://demo.redmine.org'
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

  def teardown
    @driver.quit
  end
end