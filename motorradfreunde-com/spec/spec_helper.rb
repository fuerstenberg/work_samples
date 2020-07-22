ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-webkit'
require 'turnip/capybara'
require 'support/geocoder'
# require 'shoulda/matchers/integrations/rspec'

Dir[Rails.root.join("spec/models/concerns/**/*.rb"  )].each { |f| require f }
Dir[Rails.root.join("spec/features/steps/**/*.rb"  )].each { |f| require f }

Capybara.configure do |config|
  config.run_server = true
  config.javascript_driver = :webkit
end

RSpec.configure do |config|
  config.expose_current_running_example_as :example
  config.use_transactional_fixtures = false

  config.include Capybara::Features
  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers

  Warden.test_mode!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before(:each, js: true) do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Warden.test_reset! # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  end
end
