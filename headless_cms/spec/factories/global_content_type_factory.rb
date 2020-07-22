FactoryBot.define do
  factory :global_content_type do
    sequence(:name) { |n| "Global content type #{n}" }
    description {"This is a global content type for shoes."}
  end

  factory :global_content_type_person, class: GlobalContentType do
    sequence(:name) { |index| "Person global content type #{index}" }
    description {"A special global content type for creating people..."}

    after(:create) do |global_content_type|
      create :content_field_boolean_good_person,   global_content_type: global_content_type
      create :content_field_decimal_body_size,     global_content_type: global_content_type
      create :content_field_integer_age,           global_content_type: global_content_type
      create :content_field_long_text_description, global_content_type: global_content_type
      create :content_field_short_text_name,       global_content_type: global_content_type
      create :content_field_time_birthday,         global_content_type: global_content_type
      create :content_field_images,                global_content_type: global_content_type, name: "Images"
      create :content_field_image,                 global_content_type: global_content_type, name: "Image"
    end
  end

  factory :global_content_type_image_gallery, class: GlobalContentType do
    sequence(:name) { |index| "Image gallery global content type #{index}" }
    description {"A special global content type for creating images..."}

    after(:create) do |global_content_type|
      create :content_field_short_text_name, global_content_type: global_content_type
      create :content_field_images,          global_content_type: global_content_type
    end
  end

  factory :global_content_type_image, class: GlobalContentType do
    sequence(:name) { |index| "One image only global content type #{index}" }
    description {"A special global content type for creating one image..."}

    after(:create) do |global_content_type|
      create :content_field_short_text_name, global_content_type: global_content_type
      create :content_field_image,           global_content_type: global_content_type
    end
  end
end
