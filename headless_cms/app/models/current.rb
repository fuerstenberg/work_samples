class Current

  def self.customer
    Thread.current[:customer]
  end

  def self.customer?
    !Thread.current[:customer].nil?
  end

  def self.customer=(customer = nil)
    if customer.nil?
      Thread.current[:customer] = nil
      customer_database = nil
    elsif customer and customer.is_a?(Customer)
      Thread.current[:customer] = customer
    else
      Thread.current[:customer] = Customer.find(customer)
    end
    # customer_database = Thread.current[:customer]&.database_name
    Thread.current[:customer]
  end

  def self.customer_database
    if Rails.env.test? || !customer?
      Mongoid.default_client.database.name
    else
      Thread.current[:customer]&.database_name
    end
  end

  # def self.customer_database=(customer_database_name = nil)
  #   # Thread.current[:customer_database] = customer_database_name
  # end

  def self.locale
    Thread.current[:locale]
  end

  def self.locale=(locale)
    Thread.current[:locale] = locale
  end

  def self.user
    Thread.current[:user]
  end

  def self.user=(user)
    Thread.current[:user] = user
  end

end
