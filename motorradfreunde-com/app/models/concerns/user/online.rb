module Concerns::User::Online

  extend ActiveSupport::Concern

  included do
    scope :online,    -> { where(:updated_at.gt => Time.now - 10.minutes) }
    scope :is_online, -> { where(:updated_at.gt => Time.now - 10.minutes) }
  end

  def is_online!
    self.touch :updated_at
  end

end
