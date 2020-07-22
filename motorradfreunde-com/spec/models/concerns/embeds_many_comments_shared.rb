shared_examples 'embeds many comments' do |parent|
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to embed_many(:comments).with_polymorphism.ordered_by(:created_at.asc) }
  end

  context 'fields' do
    it { is_expected.to accept_nested_attributes_for(:comments) }
    it { is_expected.to have_field(:comments_count).of_type(Fixnum).with_default_value_of(0) }
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
