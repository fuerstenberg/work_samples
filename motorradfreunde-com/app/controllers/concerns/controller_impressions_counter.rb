module Concerns::ControllerImpressionsCounter

  extend ActiveSupport::Concern

  included do
    after_action :count_impression
  end

  private

  def count_impression
    klass = self.class.to_s.split("::")[-1].gsub("Controller", "").classify.constantize
    if request.get? and %w(show).include?(action_name) and params[:id].present? and klass.respond_to?(:count_impression)
      klass.count_impression(params[:id])
    end
  rescue
    nil
  end

end
