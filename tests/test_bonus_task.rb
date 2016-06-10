require 'selenium-webdriver'
require 'test/unit'
require_relative 'our_module'

class TestRedmineMainTask < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome
  end

  def test_hover
    @driver.navigate.to 'https://the-internet.herokuapp.com/hovers'
    element = @driver.find_element(:class, 'figure')
    @driver.mouse.move_to(element)
    assert(@driver.find_element(:class, 'figcaption').displayed?)
  end

  def test_drag_n_drop
    @driver.navigate.to 'https://the-internet.herokuapp.com/drag_and_drop'
    dnd_javascript = File.read(Dir.pwd + '/drag_and_drop_helper.js')
    @driver.execute_script(dnd_javascript+"$('#column-a').simulateDragDrop({ dropTarget: '#column-b'});")

    assert(@driver.find_element(id: 'column-a').text.include?('B') && @driver.find_element(id: 'column-b').text.include?('A'))
  end

  def test_select_list
    @driver.navigate.to 'https://the-internet.herokuapp.com/dropdown'

    dropdown = @driver.find_element(:id, 'dropdown')
    options = dropdown.find_elements(:tag_name, 'option')
    options.each { |option| option.click if option.text == 'Option 2'}
    selected_option = options.map {|option| option.text if option.selected? }.join
    assert(selected_option.eql? ('Option 2'))
  end

  def test_iframes
    @driver.navigate.to 'https://the-internet.herokuapp.com/iframe'
    input_text = 'Hello World!'
    @driver.switch_to.frame('mce_0_ifr')
    editor = @driver.find_element(:id, 'tinymce')
    editor.send_keys input_text
    assert(editor.find_element(:css, 'p').text.include? (input_text))
  end

  def test_key_press
    @driver.navigate.to 'https://the-internet.herokuapp.com/key_presses'

    @driver.action.send_keys(:enter).perform
    assert(@driver.find_element(:id, 'result').text.include?('ENTER'))
  end

  def test_jquery_menu
    @driver.navigate.to 'https://the-internet.herokuapp.com/jqueryui/menu'

    first_element = @driver.find_element(:id, 'ui-id-3')
    second_element = @driver.find_element(:id, 'ui-id-4')
    third_element = @driver.find_element(:id, 'ui-id-5')

    @driver.mouse.move_to(first_element)
    wait.until {second_element.displayed?}
    @driver.mouse.move_to(second_element)
    wait.until {third_element.displayed?}
    assert(@driver.find_element(:css, "a[href='/download/jqueryui/menu/menu.pdf']").displayed?)
  end

  def test_javascript_alerts
    @driver.navigate.to 'https://the-internet.herokuapp.com/javascript_alerts'

    @driver.find_element(:css, "button[onclick*='jsAlert()']").click
    @driver.switch_to.alert.accept
    assert(@driver.find_element(:id, 'result').text == 'You successfuly clicked an alert')
  end

  def test_multiple_windows
    @driver.navigate.to 'https://the-internet.herokuapp.com/windows'

    @driver.find_element(:css, "a[href='/windows/new']").click
    new_tab = @driver.window_handles[1]
    @driver.switch_to.window(new_tab)
    assert(@driver.current_url.eql? 'https://the-internet.herokuapp.com/windows/new')
    assert(@driver.find_element(:css, 'h3').displayed?)
  end

  def teardown
    @driver.quit
  end

end