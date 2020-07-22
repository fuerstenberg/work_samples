class CustomerMailer < ActionMailer::Base

  default from: "\"Motorradfreunde.com\" <info@motorradfreunde.com>"

  def advertising_email(customer)
    @customer = customer
    mail to: @customer.email, subject: "[Marketing] Motorradfreunde.com"
  end

end
