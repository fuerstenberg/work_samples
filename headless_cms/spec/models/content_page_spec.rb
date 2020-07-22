require 'rails_helper'

RSpec.describe ContentPage, type: :model do

  context 'general' do
    it { expect(described_class.superclass).to be ContentNode }
  end

  context 'validations' do
    let(:content_page) { build(:content_page, parent: nil) }

    it 'must have parent' do
      expect(content_page).not_to be_valid
      expect(content_page.errors.full_messages_for(:parent)).to eq ["Parent must be a content page or content tree"]
    end
  end

end
