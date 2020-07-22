require 'rspec'
require 'capybara/rspec'
require 'rails_helper'

Dir[Rails.root.join("spec/features/steps/*.rb")].each {|f| require f}
