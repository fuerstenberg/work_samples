RSpec.shared_examples "content/search" do |parameter|

  context 'associations' do
    it { is_expected.to embed_many :releases }
  end

  context 'fields' do
    it { is_expected.to have_field :_keywords }
    # it { is_expected.to have_index_for(_keywords: 1).with_options(background: true) }
  end

  context 'callbacks' do
    it 'should call update_search_index on after_save' do
      content = build :content
      expect(content).to receive(:update_search_index).once
      content.save
    end
  end

  context 'methods' do
    context '#update_search_index' do
      it 'should update the search index manually' do
        content = build :content
        content.save
        expect(content._keywords).to eq [content.id.to_s]
      end
    end
  end
end
