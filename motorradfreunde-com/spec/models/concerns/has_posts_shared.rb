shared_examples 'has posts' do |parent|
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to have_many(:posts).with_polymorphism }
  end

  context 'fields' do
  end

  context 'validations' do
  end

  context 'callbacks' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
