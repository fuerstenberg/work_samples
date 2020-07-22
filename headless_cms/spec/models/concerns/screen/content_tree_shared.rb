RSpec.shared_examples "Concerns::Screen::ContentTree" do |parameter|
  context 'associations' do
    it { is_expected.to belong_to(:content_tree) }
  end
end
