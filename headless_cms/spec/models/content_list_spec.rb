require 'rails_helper'

RSpec.describe ContentList, type: :model do
  let(:content_list) { create(:content_list, :with_leafs) }

  context 'general' do
    it { expect(described_class.superclass).to be ContentNode }
    it { expect(content_list).to be_persisted }
  end

  context 'associations' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to have_many(:screens) }
  end

  context 'validations' do
    it 'must be root' do
      content_list.parent = create(:content_node)
      expect(content_list).not_to be_valid
      expect(content_list.errors.full_messages_for(:parent)).to eq ["Parent must be empty"]
    end
  end

end
