require 'rails_helper'

RSpec.describe ContentTree, type: :model do
  let(:content_tree) { create(:content_tree, :with_leafs, :with_pages) }

  context 'general' do
    it { expect(described_class.superclass).to be ContentNode }
    it { expect(content_tree).to be_persisted }
  end

  context 'associations' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to have_many(:screens) }
  end

  context 'validations' do
    it 'must be root' do
      content_tree.parent = create(:content_node)
      expect(content_tree).not_to be_valid
      expect(content_tree.errors.full_messages_for(:parent)).to eq ["Parent must be empty"]
    end
  end

end
