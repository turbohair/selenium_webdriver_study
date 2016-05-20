require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to 'http://demo.redmine.org'
  end

  def test_create_issue_type_bug
    register_user
    create_project
    create_issue('bug')
    issue_type_header = @driver.find_element(:xpath, "//*[@id='content']//*[contains(text(), 'Bug')]")
    assert(issue_type_header.displayed?)
  end

  def test_create_issue_type_feature
    register_user
    create_project
    create_issue('feature')
    issue_type_header = @driver.find_element(:xpath, "//*[@id='content']//*[contains(text(), 'Feature')]")
    assert(issue_type_header.displayed?)
  end

  def test_create_issue_type_support
    register_user
    create_project
    create_issue('support')
    issue_type_header = @driver.find_element(:xpath, "//*[@id='content']//*[contains(text(), 'Support')]")
    assert(issue_type_header.displayed?)
  end

  def teardown
    @driver.quit
  end
end
