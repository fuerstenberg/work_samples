FactoryBot.define do
  factory :content_type do
    customer { Current.customer || create(:customer) }
    sequence(:name) { |n| "Content type #{n}" }
    description {"This is a content type for shoes."}
  end

  factory :person_content_type, class: ContentType do
    customer { Current.customer }
    sequence(:name) { |index| "Person content type #{index}" }
    description {"A special content type for creating people..."}

    after(:create) do |content_type|
      create :content_field_boolean_good_person,   content_type: content_type
      create :content_field_decimal_body_size,     content_type: content_type
      create :content_field_integer_age,           content_type: content_type
      create :content_field_long_text_description, content_type: content_type
      create :content_field_short_text_name,       content_type: content_type
      create :content_field_time_birthday,         content_type: content_type
      create :content_field_images,                content_type: content_type, name: "Images"
      create :content_field_image,                 content_type: content_type, name: "Image"
    end
  end

  factory :an_image_gallery_content_type, class: ContentType do
    customer { Current.customer || create(:customer) }
    sequence(:name) { |index| "Image gallery content type #{index}" }
    description {"A special content type for creating images..."}

    after(:create) do |content_type|
      create :content_field_short_text_name, content_type: content_type
      create :content_field_images,          content_type: content_type
    end
  end

  factory :an_image_content_type, class: ContentType do
    customer { Current.customer || create(:customer) }
    sequence(:name) { |index| "One image only content type #{index}" }
    description {"A special content type for creating one image..."}

    after(:create) do |content_type|
      create :content_field_short_text_name, content_type: content_type
      create :content_field_image,          content_type: content_type
    end
  end

  factory :an_video_content_type, class: ContentType do
    customer { Current.customer || create(:customer) }
    sequence(:name) { |index| "One video only content type #{index}" }
    description {"A special content type for creating one video..."}

    after(:create) do |content_type|
      create :content_field_short_text_name, content_type: content_type
      create :content_field_video,          content_type: content_type
    end
  end
end
