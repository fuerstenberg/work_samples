module Concerns::Content::RawDataSets

  extend ActiveSupport::Concern

  included do
    has_many :raw_data_sets, autosave: true

    accepts_nested_attributes_for :raw_data_sets, reject_if: proc { |attributes| attributes.all? { |key, value| key == '_destroy' || value.blank? } }
  end

end
