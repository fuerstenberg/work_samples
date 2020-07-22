describe Route do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "embeds many comments", FactoryGirl.create(:route)
    it_behaves_like "has impressions"
    it_behaves_like "has many activities", :route
  end

  context 'associations' do
    it { is_expected.to belong_to(:routable).with_polymorphism }
    it { is_expected.to belong_to(:user    ) }
    it { is_expected.to embed_many(:waypoints).with_cascading_callbacks }
  end

  context 'fields' do
    it { is_expected.to have_field(:description    ).of_type(String) }
    it { is_expected.to have_field(:distance       ).of_type(Integer) }
    it { is_expected.to have_field(:end_address    ).of_type(String) }
    it { is_expected.to have_field(:name           ).of_type(String) }
    it { is_expected.to have_field(:start_address  ).of_type(String) }
    it { is_expected.to have_field(:static_polyline).of_type(String) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  context 'class methods' do
  end

  context 'instance methods' do

    it 'distance_in_km should return distance in km' do
      subject.distance = 123456
      expect(subject.distance_in_km).to eq (subject.distance/1000).round
    end

    it 'to_description should return description' do
      subject.description = 'my description'
      expect(subject.to_description).to be subject.description
    end

    it 'to_keywords should return to_s' do
      expect(subject.to_keywords).to eq subject.to_s
    end

    it 'to_param should return slug' do
      slug = 'my-unique-url'
      expect(subject).to receive(:slug).and_return slug
      expect(subject.to_param).to be slug
    end

    it 'to_s should return the name' do
      subject.name = 'my-name'
      expect(subject.to_s).to be subject.name
    end

    it 'to_subtitle should return distance_in_km' do
      expect(subject).to receive(:distance_in_km).and_return 1234
      expect(subject.to_subtitle).to eq '1234 km'
    end

    it 'to_title should return to_s' do
      subject.name = 'my-name'
      expect(subject.to_title).to eq subject.to_s
    end

  end
end
