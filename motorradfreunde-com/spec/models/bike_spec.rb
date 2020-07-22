describe Bike do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "embeds many comments", FactoryGirl.create(:bike)
    it_behaves_like "embeds many images"
    it_behaves_like "has impressions"
    it_behaves_like "has many activities", :bike
    # include Concerns::HasMetaMethods
    # include Concerns::HasDefaultScopes
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:vendor).with_counter_cache }
  end

  context 'fields' do
    it { is_expected.to have_field(:category           ).of_type(String) }
    it { is_expected.to have_field(:ccm                ).of_type(Integer) }
    it { is_expected.to have_field(:color              ).of_type(String) }
    it { is_expected.to have_field(:description        ).of_type(String) }
    it { is_expected.to have_field(:hp                 ).of_type(Integer) }
    it { is_expected.to have_field(:model              ).of_type(String) }
    it { is_expected.to have_field(:permalink          ).of_type(String) }
    it { is_expected.to have_field(:property           ).of_type(String) }
    it { is_expected.to have_field(:vendor_name        ).of_type(String) }
    it { is_expected.to have_field(:year_of_manufacture).of_type(DateTime) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:poi_id) }
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to validate_numericality_of(:ccm) }
    it { is_expected.to validate_numericality_of(:hp) }
  end

  context 'class methods' do
  end

  context 'instance methods' do
    let(:vendor) { create :vendor }
    it 'to_description should return a shortened description' do
      subject.description = "Description " * 20
      expect(subject.to_description).to eq subject.description[0,155]
    end

    it 'to_keywords should return some keywords' do
      subject.vendor = vendor
      subject.model = 'K 1200 R'
      subject.ccm = 1200
      subject.hp = 163
      subject.year_of_manufacture = 2008
      expect(subject.to_keywords).to eq 'BMW,K 1200 R,1200 ccm,163 PS,2008'
    end

    it 'to_param should return slug' do
      slug = 'a-slug-generated-by-stringex'
      expect(subject).to receive(:slug).and_return slug
      expect(subject.to_param).to be slug
    end

    it 'to_s should return the vendor and model' do
      subject.vendor = vendor
      subject.model = 'K 1200 R'
      expect(subject.to_s).to eq [subject.vendor, subject.model].join(" ")
    end

    it 'to_subtitle should return to_s' do
      expect(subject.to_subtitle).to eq subject.to_s
    end

    it 'to_title should return to_s' do
      expect(subject.to_title).to eq subject.to_s
    end
  end
end
