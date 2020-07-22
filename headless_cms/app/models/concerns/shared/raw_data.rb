module Concerns::Shared::RawData

  extend ActiveSupport::Concern

  included do
    field :raw_json_data, type: String, default: nil
    field :raw_xml_data,  type: String, default: nil
  end

end
