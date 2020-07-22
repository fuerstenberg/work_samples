RSpec.shared_examples "Concerns::Screen::ContentList" do |parameter|
  context 'associations' do
    it { is_expected.to belong_to(:content_list) }
  end
end
