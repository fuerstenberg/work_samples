FactoryBot.define do

  factory :content_field_base, class: ContentField::Base do
    localized   {false}
    name        {"Name"}
    required    {true}
    validations {[]}
  end

  # factory :content_field_name, parent: :content_field_base, class: ContentField::ShortText do
  factory :content_field_name, class: ContentField::ShortText do
    name        {"Name"}
    required    {true}
    localized   {false}
    validations {[]}
  end

  factory :content_field_description, parent: :content_field_base, class: ContentField::LongText do
    name        {"Description"}
    required    {false}
  end

  factory :content_field_boolean_good_person, class: ContentField::Boolean do
    name {"Good person"}
    required    {true}
    localized   {false}
    validations {[]}
  end

  factory :content_field_decimal_body_size, class: ContentField::Decimal do
    name {"Body size"}
    required    {true}
    localized   {false}
    validations {[]}
  end

  factory :content_field_integer_age, class: ContentField::Integer do
    name {"Age"}
    required    {true}
    localized   {false}
    validations {[]}
  end

  factory :content_field_long_text_description, class: ContentField::LongText do
    name {"Description"}
    required    {true}
    localized   {false}
    validations {[]}
  end

  factory :content_field_short_text_name, class: ContentField::ShortText do
    name {"Name"}
    required    {true}
    localized   {false}
    validations {[]}
  end

  factory :content_field_time_birthday, class: ContentField::Time do
    name {"Birthday"}
    required    {true}
    localized   {false}
    validations {[]}
  end

  factory :content_field_images, class: ContentField::Image do
    name {"Image"} # field_id should be images, because of has_many true
    has_many    {true}
    required    {false}
    localized   {false}
    validations {[]}
  end

  factory :content_field_image, class: ContentField::Image do
    name {"Image"}
    has_many    {false}
    required    {false}
    localized   {false}
    validations {[]}
  end

  factory :content_field_video, class: ContentField::Video do
    name {"Video"}
    has_many    {false}
    required    {false}
    localized   {false}
    validations {[]}
  end

end
