# -*- coding: utf-8 -*-
# frozen_string_literal: true

# 必要ファイルの読み込み
require 'selenium-webdriver'
require 'capybara/rspec'
require 'site_prism'
#require 'screen-recorder'

require 'active_support'
require 'webdrivers/chromedriver'
require 'webdrivers/geckodriver'


# spec/pages,spec/test以下をロードする
ActiveSupport::Dependencies.autoload_paths << "#{File.expand_path(File.dirname(__FILE__))}/pages"
ActiveSupport::Dependencies.autoload_paths << "#{File.expand_path(File.dirname(__FILE__))}/test"

EXECUTABLE_BROWSERS = ['ie','internet_explorer','chrome','firefox','safari','edge_chrome']
webbrowser = ENV['BROWSER'] || 'chrome'
webbrowser = 'chrome' unless EXECUTABLE_BROWSERS.include?(webbrowser)

# remote or local
if ENV['IS_REMOTE'] == 'true' then

  host = ENV['RUN_REMOTE_HOST'] || '127.0.0.1'
  port = ENV['RUN_REMOTE_PORT'] || '4444'

  Capybara.register_driver :remote_server do |app|

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: "http://#{host}:#{port}/",
      desired_capabilities: webbrowser.to_sym
    )
  end

  # capybaraの設定
  Capybara.configure do |config|
    config.default_driver         = :remote_server
    config.javascript_driver      = :remote_server
    config.run_server = false
    config.app_host = ENV.fetch('CAPYBARA_HOST_URL', 'https://www.google.co.jp')
    config.default_max_wait_time = ENV.fetch('MAX_WAIT_TIME', 10).to_i
  end

else 

  # ブラウザの切り替え
  # browser (:ie, :internet_explorer, :edge_chrome, :remote, :chrome, :firefox, :ff, :safari)
  Capybara.register_driver :selenium do |app|
  # http://code.google.com/p/chromedriver/downloads/list
    browser=ENV.fetch('BROWSER','chrome').to_sym
    if browser == :chrome then
      options = Selenium::WebDriver::Chrome::Options.new
      prefs = {
        prompt_for_download: false,	
        default_directory: ENV.fetch('WORKSPACE', '/tmp')	
      }	
      options.add_preference(:download , prefs)
      options.add_argument('--no-sandbox')
      if ENV['GITHUB_ACTIONS'] == 'true'
        options.add_argument('headless')
        options.add_argument('disable-gpu') if Gem.win_platform?
      end
      Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
    else
      Capybara::Selenium::Driver.new(app, browser: browser)
    end
  end

  # capybaraの設定
  Capybara.configure do |config|
    config.default_driver = :selenium
    config.run_server = false
    config.app_host = ENV.fetch('CAPYBARA_HOST_URL', 'https://www.google.co.jp')
    config.default_max_wait_time = ENV.fetch('MAX_WAIT_TIME', 3).to_i
  end

end

RSpec.configure do |config|
  config.include Capybara::DSL
  Webdrivers::Chromedriver.update
  Capybara.page.driver.browser.manage.window.maximize
  config.before do |event|
#    @recorder = ScreenRecorder::Desktop.new(output: 'spec/reports/recording.mkv')
#    @recorder.start
  end
  config.after do |event|
#    sleep 3
#    @recorder.stop
#    @recorder.video
#    @recorder.video.transcode("spec/reports/recording.mp4") { |progress| puts progress } 
  end
end

