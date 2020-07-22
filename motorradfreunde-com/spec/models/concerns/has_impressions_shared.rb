shared_examples 'has impressions' do |parent|
  context 'general' do
  end

  context 'concerns' do
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:impressions_count).of_type(Fixnum).with_default_value_of(0) }
  end

  context 'validations' do
  end

  context 'class methods' do
    it 'count_impression should count an impression for a slug param' do
      slug = 'any-slug'
      expect(subject.class).to receive(:find_by).with(slug: slug).and_return subject
      expect(subject).to receive(:count_impression)
      subject.class.count_impression slug
    end

    it 'count_impression should count an impression for a id param' do
      id = '123456'
      expect(subject.class).to receive(:find_by).with(slug: id).and_throw Mongoid::Errors::DocumentNotFound
      expect(subject.class).to receive(:find).with(id).and_return subject
      expect(subject).to receive(:count_impression)
      subject.class.count_impression id
    end
  end

  context 'instance methods' do
    it 'count_impression should increment impressions_count' do
      expect{ subject.count_impression }.to change(subject, :impressions_count).by(1)
    end
  end
end
