require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @driver.navigate.to 'http://demo.redmine.org'
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

    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    @driver.quit
  end
end
