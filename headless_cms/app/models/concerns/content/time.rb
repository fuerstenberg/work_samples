module Concerns::Content::Time

  extend ActiveSupport::Concern

  included do

    before_validation :type_cast_time_attributes

  end

  private

  # before_validation
  def type_cast_time_attributes
    # try parse Time from these params: start_at(1i): "2016", start_at(2i): "4", start_at(3i): "13", start_at(4i): "19", start_at(5i): "13">
    return unless self.content_type
    self.content_type.content_fields.where(_type: "ContentField::Time").each do |content_field|
      date = [
        "#{self[content_field.field_id + "(1i)"]}",
        "#{self[content_field.field_id + "(2i)"]}",
        "#{self[content_field.field_id + "(3i)"]}"
      ].select(&:present?).join("-")
      time = [
        "#{self[content_field.field_id + "(4i)"]}",
        "#{self[content_field.field_id + "(5i)"]}",
        "#{self[content_field.field_id + "(6i)"]}"
      ].select(&:present?).join(":")
      if date.present?
        self[content_field.field_id] = Time.parse("#{date} #{time}")
      elsif self[content_field.field_id].is_a?(String)
        self[content_field.field_id] = Time.parse(self[content_field.field_id]) rescue nil
      end
    end
  end

end
