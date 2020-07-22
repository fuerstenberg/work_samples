describe Poi do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "a bike builder"
    it_behaves_like "a dealer"
    it_behaves_like "a general poi"
    it_behaves_like "a hotel"
    it_behaves_like "a magazin"
    it_behaves_like "a mountain pass"
    it_behaves_like "a rental company"
    it_behaves_like "a shop"
    it_behaves_like "a tour operator"
    it_behaves_like "a vendor"
    it_behaves_like "a workshop"
    it_behaves_like "embeds many feeds"
    it_behaves_like "embeds many images"
    it_behaves_like "embeds one address", FactoryGirl.create(:poi, :with_address)
    it_behaves_like "has impressions"
    it_behaves_like "has many activities", :poi
    it_behaves_like "has many posts"
  end

  context 'associations' do
    # it { is_expected.to have_many(:routes), dependent: :destroy, as: :routable }
    it { is_expected.to belong_to(:creator).as_inverse_of(:created_pois) }
    it { is_expected.to belong_to(:editor ).as_inverse_of(:edited_pois) }
    it { is_expected.to belong_to(:owner  ).as_inverse_of(:owned_pois) }
  end

  context 'fields' do
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  context 'class methods' do
  end

  context 'instance methods' do
    it 'should test all methods'

    it 'to_s should return the name' do
      subject.name = 'BMW'
      expect(subject.to_s).to eq subject.name
    end

    it 'to_param should return slug' do
      slug = 'a-slug-generated-by-stringex'
      expect(subject).to receive(:slug).and_return slug
      expect(subject.to_param).to be slug
    end
  end
end
