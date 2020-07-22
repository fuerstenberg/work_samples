module CustomersHelper

  def customer_logo_image_tag(customer, format = :small, options = {})
    if logo = customer_logo_url(customer, format)
      image_tag logo, options
    end
  end

  def customer_logo_url(customer, format = :small)
    if customer and customer.logo?
      customer.logo.url format
    end
  end

end
