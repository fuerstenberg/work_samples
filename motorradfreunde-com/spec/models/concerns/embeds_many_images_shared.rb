shared_examples 'embeds many images' do |parent|
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to embed_many(:images).with_polymorphism.with_cascading_callbacks }
  end

  context 'fields' do
    it { is_expected.to have_field(:images_count).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to accept_nested_attributes_for(:images) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
    it 'nested_reject_if_for_images'
    it 'avatar_image'
  end
end
