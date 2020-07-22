describe RideRequest do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "embeds many comments", FactoryGirl.create(:ride_request)
    it_behaves_like "has impressions"
    it_behaves_like "has many activities", :ride_request
  end

  context 'associations' do
  end

  context 'fields' do
  end

  context 'validations' do
  end

  context 'class methods' do
  end

  context 'instance methods' do
  end
end

# require 'rails_helper'
#
# describe RideRequest do
#
#   context "concerns" do
#     it_behaves_like "a mapable"
#   end
#
# end
