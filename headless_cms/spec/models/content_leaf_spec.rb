require 'rails_helper'

RSpec.describe ContentLeaf, type: :model do
  let(:customer) { create :customer }

  context 'general' do
    it { expect(described_class.superclass).to be ContentNode }
    it { expect(create(:content_leaf, parent: create(:content_list))).to be_persisted }
  end

  context 'validations' do
    let(:content_leaf) { build(:content_leaf) }

    it 'must have parent' do
      expect(content_leaf).not_to be_valid
      expect(content_leaf.errors.full_messages_for(:parent)).to eq ["Parent must be a content page, content list or content tree"]
    end
  end

end
