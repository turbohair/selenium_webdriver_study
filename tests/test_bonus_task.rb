require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'
require_relative 'helpers_module'

class TestRedmineMainTask < Test::Unit::TestCase
  include OurModule
  include HelpersModule

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @base_url = 'https://the-internet.herokuapp.com'
  end

  # def test_hover
  #   @driver.navigate.to @base_url + '/hovers'
  #   element = @driver.find_element(:class, 'figure')
  #   @driver.mouse.move_to(element)
  #   assert(@driver.find_element(:class, 'figcaption').displayed?)
  # end

  def test_drag_n_drop
    @driver.navigate.to @base_url + '/drag_and_drop'
    dnd_javascript = File.read(Dir.pwd + '/drag_and_drop_helper.js')
    @driver.execute_script(dnd_javascript+"$('#column-a').simulateDragDrop({ dropTarget: '#column-b'});")

    @driver.find_element(id: 'column-a').text.include?('B')
    @driver.find_element(id: 'column-b').text.include?('A')
  end

  def test_select_list

  end

  # iframes
  # key press
  # JQueryUI menu
  # Javascrip alerts
  # Multiple Windows



  def teardown
    @driver.quit
  end

end