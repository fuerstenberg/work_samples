FactoryBot.define do
  factory :content do
    content_type { create :content_type }
    customer { Current.customer || create(:customer) }

    factory :homer_simpson do
      association :content_type, factory: [:person_content_type]

      name {"Homer Simpson"}
      description {"A popular beer drinker..."}
      birthday { Time.now - 38.years }
      goodPerson {true}
      bodySize {1.84}
      age {38}
      foreign_id { "abc123456789#{rand 9999999}" }
      _checksum {'123456789'}
    end

    factory :an_image do
      association :content_type, factory: [:an_image_content_type]

      name {"An image"}
      # image { create :image }
      image_attributes { { file: File.new(Rails.root + 'spec/support/test_500_500.png') } }
    end

    factory :a_video do
      association :content_type, factory: [:an_video_content_type]

      name {"A video"}
      video_attributes { { file: File.new(Rails.root + 'spec/support/test.mov') } }
    end

    factory :a_gallery do
      association :content_type, factory: [:an_image_gallery_content_type]

      name {"Image gallery"}
      # images {}
      images_attributes { [{ file: File.new(Rails.root + 'spec/support/test_500_500.png') }] }
    end
  end
end
