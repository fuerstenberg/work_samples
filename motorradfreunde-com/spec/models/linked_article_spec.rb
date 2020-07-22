describe LinkedArticle do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "is feed item"
  end

  context 'associations' do
  end

  context 'fields' do
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end
