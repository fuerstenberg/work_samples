require 'rails_helper'

RSpec.describe ContentNode, type: :model do

  let(:customer) { create :customer }

  describe 'fields' do
    it { is_expected.to have_field(:name).of_type(String) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

end
