require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('no-sandbox')
  options.add_argument('headless')
  options.add_argument('disable-gpu')
  options.add_argument('window-size=1680,1050')

  driver_url = ENV['SELENIUM_DRIVER_URL'] || 'http://localhost:4444/wd/hub'

  Capybara::Selenium::Driver.new(app, browser: :remote, url: driver_url, capabilities: options)
end
