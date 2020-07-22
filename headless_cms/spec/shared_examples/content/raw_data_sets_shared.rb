RSpec.shared_examples "content/raw_data_sets" do |parameter|

  context 'associations' do
    it { is_expected.to have_many :raw_data_sets }
  end

  context 'methods' do
    let(:content) { build(:content) }
    let(:xml) { '<content>lorem ipsum dolor</content>' }

    it 'should save a content with a raw data set' do
      content.raw_data_sets_attributes = [
        { xml: xml }
      ]
      content.save
      expect(content.raw_data_sets.first.xml).to eq xml
    end

    it 'should save a content with a second raw data set' do
      content.raw_data_sets_attributes = [
        { xml: xml }
      ]
      content.save
      content.raw_data_sets_attributes = [
        { xml: xml }
      ]
      content.save
      expect(content.raw_data_sets.count).to eq 2
      expect(content.raw_data_sets.first.xml).to eq xml
      expect(content.raw_data_sets.last.xml).to eq xml
    end

    it 'should save a content, but should reject the empty raw data set' do
      content.raw_data_sets_attributes = [{ xml: '' }]
      content.save
      expect(content.raw_data_sets.first).to be nil
    end
  end

end
