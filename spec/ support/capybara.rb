require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('no-sandbox')
  options.add_argument('headless')
  options.add_argument('disable-gpu')
  options.add_argument('window-size=1680,1050')
  Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://chrome:4444/wd/hub", capabilities: options)
end

RSpec.configure do |config|
  if ENV['CODEBUILD_BUILD_ID']
    config.before(:each, type: :system) do
      driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080]
    end
  else
    config.before(:each, type: :system) do
      driven_by :remote_chrome
      Capybara.ignore_hidden_elements = false
    end
  end
end
