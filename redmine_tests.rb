require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox

driver.navigate.to 'http://demo.redmine.org'
driver.find_element(:class, 'register').click

wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until {driver.find_element(:id, 'user_login').displayed?}

driver.find_element(:id, 'user_login').send_keys 'asdfqwe'
driver.find_element(:id, 'user_password').send_keys 'asdfqwe'
driver.find_element(:id, 'user_password_confirmation').send_keys 'asdfqwe'
driver.find_element(:id, 'user_firstname').send_keys 'asdfqwe'
driver.find_element(:id, 'user_lastname').send_keys 'asdfqwe'
driver.find_element(:id, 'user_mail').send_keys 'asdfqwe@asdfasdf.com.ua'
sleep 5
driver.find_element(:name, 'commit').click

sleep 5

raise unless (driver.find_element(:id, 'flash_notice').text == 'Your account has been activated. You can now log in.')
driver.quit