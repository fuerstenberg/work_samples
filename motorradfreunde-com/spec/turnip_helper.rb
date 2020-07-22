Dir[Rails.root.join("spec/acceptance/steps/*steps.rb")].each { |f| require f }

RSpec.configure do |config|

  config.include GeneralSteps
  config.include UserSteps

end
