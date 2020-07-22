describe Image do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "has many activities", :image_on_bike
    it 'should be sortable'
  end

  context 'associations' do
    it { is_expected.to be_embedded_in(:imageable).with_polymorphism }
    it { is_expected.to belong_to(:user) }
  end

  context 'fields' do
    it { is_expected.to have_field(:avatar  ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:cover   ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:position).of_type(Integer) }
    it { is_expected.to respond_to(:file) }
    it { expect(subject.file).to receive(:url); subject.url }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:file) }
    it { is_expected.to validate_presence_of(:file_url) }
  end

  context 'class methods' do
    it 'should return a cover image'
  end

  context 'instance methods' do
    it 'should update the images_count of the parent object'
  end
end
