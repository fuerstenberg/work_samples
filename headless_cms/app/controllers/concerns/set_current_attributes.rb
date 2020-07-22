module Concerns::SetCurrentAttributes
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
    before_action :set_current_locale
    before_action :set_current_customer_by_customer_id
  end

  private

  def set_current_customer_by_customer_id(customer_id: params[:customer_id])
    # id ||= params[:customer_id]
    Current.customer = @customer = customer_id ? ::Customer.find(customer_id) : nil
    authorize! :read, Current.customer if Current.customer
  end

  def set_current_customer_by_id
    set_current_customer_by_customer_id customer_id: params[:id]
  end

  def set_current_locale
    if current_user && current_user.language
      I18n.locale = current_user.language
    else
      I18n.locale = :de
    end
  end

  def set_current_user
    if user_signed_in?
      Current.user = current_user
    else
      Current.user = nil
    end
  end

end
