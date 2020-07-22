module Concerns::Content::Sortable

  extend ActiveSupport::Concern

  included do
    field :order, type: Integer, default: 0

    before_save :set_default_order

    scope :ordered, ->{ order(order: :asc) }
  end

  module ClassMethods
    def sort_by_ids(ids)
      ids.each_with_index do |id, index|
        # index + 1  to prevent a 0 in order field, because 0 is the default value
        self.find(id).set(order: index + 1)
      end
    end
  end

  private

  def set_default_order
    if self.customer and self.order.nil? or self.order.zero?
      self.order = self.customer.contents.count
    end
  end

end
