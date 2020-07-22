module Concerns::IsAdminReporter

  extend ActiveSupport::Concern

  included do
    after_save :report_to_admin
    handle_asynchronously :report_to_admin
  end

  module ClassMethods
  end

  def report_to_admin
    AdminMailer.report_to_admin(self).deliver
  end

end
