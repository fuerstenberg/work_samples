describe Video do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    # include Concerns::HasMetaMethods
    it_behaves_like "has impressions"
    it_behaves_like "has many activities", :video
  end

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:active                 ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:author_name            ).of_type(String ) }
    it { is_expected.to have_field(:author_uri             ).of_type(String ) }
    it { is_expected.to have_field(:description            ).of_type(String ) }
    it { is_expected.to have_field(:duration               ).of_type(Integer) }
    it { is_expected.to have_field(:player_url             ).of_type(String ) }
    it { is_expected.to have_field(:title                  ).of_type(String ) }
    it { is_expected.to have_field(:unique_id              ).of_type(String ) }
    it { is_expected.to have_field(:youtube_categories     ).of_type(Array  ).with_default_value_of([]) }
    it { is_expected.to have_field(:youtube_rating_average ).of_type(Float  ) }
    it { is_expected.to have_field(:youtube_rating_count   ).of_type(Integer) }
    it { is_expected.to have_field(:youtube_rating_dislikes).of_type(Integer) }
    it { is_expected.to have_field(:youtube_rating_likes   ).of_type(Integer) }
    it { is_expected.to have_field(:youtube_video_id       ).of_type(String ) }
    it { is_expected.to have_field(:youtube_view_count     ).of_type(Integer) }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:unique_id) }
  end

  context 'class methods' do

  end

  context 'instance methods' do
    it 'thumbnail method should return a video thumbnail url' do
      subject.unique_id = 'my-unique-id'
      expect(subject.thumbnail).to eq "http://i.ytimg.com/vi/#{subject.unique_id}/hqdefault.jpg"
    end

    it 'to_keywords method should return some keywords' do
      subject.youtube_categories = ['motorrad', 'motorcycles']
      expect(subject.to_keywords).to be subject.youtube_categories
    end

    it 'to_s should return the title' do
      subject.title = 'My video title'
      expect(subject.to_s).to eq subject.title
    end

    it 'to_param should return slug' do
      slug = 'a-slug-generated-by-stringex'
      expect(subject).to receive(:slug).and_return slug
      expect(subject.to_param).to be slug
    end
  end
end
