module Concerns::Customer::Database
  extend ActiveSupport::Concern

  included do
    store_in database: ->{ Current.customer_database }
  end

end
