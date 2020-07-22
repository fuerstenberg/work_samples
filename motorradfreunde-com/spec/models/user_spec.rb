describe User do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "embeds one address", FactoryGirl.create(:user, :with_address)
    it_behaves_like "embeds many comments", FactoryGirl.create(:user)
    it_behaves_like "a conversation member or administrator"
    it_behaves_like "embeds many images"
    it_behaves_like "has impressions"
    it_behaves_like "an object which accepts devise authentication"
    it_behaves_like "an object which accepts facebook authentication"
    it_behaves_like "has many activities", :user
    it_behaves_like "an object which has notifications"
    it_behaves_like "has posts"
  end

  context 'associations' do
    it { is_expected.to have_many(:created_pois).as_inverse_of(:creator) }
    it { is_expected.to have_many(:edited_pois ).as_inverse_of(:editor) }
    it { is_expected.to have_many(:owned_pois  ).as_inverse_of(:owner) }
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
# describe User do
#
#   context "concerns" do
#     it_behaves_like "a mapable"
#   end
#
#   context "associations" do
#     it { should have_many(:articles                             ).dependent(:destroy) }
#     it { should have_many(:bikes                                ).dependent(:destroy) }
#     it { should have_many(:comments                             ).dependent(:destroy) }
#     it { should have_many(:events                               ).dependent(:destroy) }
#     it { should have_many(:followers                            ).through(:followships) }
#     it { should have_many(:followings                           ).through(:followingships) }
#     it { should have_many(:followingships                       ).dependent(:destroy).class_name("Followship") }
#     it { should have_many(:followships                          ).dependent(:destroy) }
#     it { should have_many(:photos                               ).dependent(:destroy) }
#     it { should have_one(:avatar_image).class_name("Photo") }
#   end
#
#   context "validations" do
#     before(:each) do
#       @user = FactoryGirl.create(:user)
#     end
#
#     it { should validate_acceptance_of(:terms_of_service) }
#     it { should validate_presence_of(:email ).presence    }
#     it { should validate_presence_of(:name  )             }
#   end
#
#   context "methods" do
#     before(:each) do
#       @user = FactoryGirl.build(:user)
#       expect(@user).to receive(:downcase_email).ordered
#       @user.save
#     end
#
#     it "should have a to_s method" do
#       expect(User.new(:name => "Marge Simpson").to_s).to eq "Marge Simpson"
#     end
#
#     it "should return an age" do
#       expect(User.new(:date_of_birth => Date.today - 20.years).age).to eq 20
#       expect(User.new(:date_of_birth => Date.today - 20.years - 1.day).age).to eq 20
#       expect(User.new(:date_of_birth => Date.today - 20.years + 1.day).age).to eq 19
#     end
#   end
#
#   context "facebook cookie" do
#     def setup
#       @facebook_access_token = "any-token-here"
#       @email                 = "homer.simpson@springfield.com"
#       @facebook_id           = 12345678901234567890
#
#       graph_object = mock(Koala::Facebook::GraphAPI)
#       Koala::Facebook::GraphAPI.should_receive(:new).with(@facebook_access_token).and_return graph_object
#       graph_object.should_receive(:get_object).with("me").and_return({"email" => @email})
#     end
#   end
#
#   context "facebook update user data" do
#     it "should update user from facebook user data" do
#       pending
#       user = User.new :facebook_id => 12345678901234567890
#       facebook_access_token = "any-facebook-token-here"
#       user_data = {
#         "email"       => "homer.simpson@springfield.com",
#         "name"        => "Homer Simpson",
#         "username"    => "homer.simpson",
#         "gender_list" => "male"
#       }
#       graph_object = mock(Koala::Facebook::GraphAPI)
#       Koala::Facebook::GraphAPI.should_receive(:new).with(facebook_access_token).and_return graph_object
#       graph_object.should_receive(:get_object).with("me").and_return user_data
#       graph_object.should_receive(:get_picture).with("#{user.facebook_id}", :type => "large").and_return "any-url-to-facebook-picture"
#       user.should_receive(:save).with(:validate => false)
#
#       user.update_from_facebook facebook_access_token
#       user.email.should  == user_data["email"]
#       user.name.should   == user_data["name"]
#       user.login.should  == user_data["username"]
#       user.gender_list.should == [user_data["gender"]]
#     end
#
#     it "should be a facebook user or not" do
#       user = User.new
#       expect(user).to_not be_facebooker
#       user.facebook_id = "123456789"
#       expect(user).to be_facebooker
#     end
#   end
# end
