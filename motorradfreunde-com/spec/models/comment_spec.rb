describe Comment do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'concerns' do
    it_behaves_like "embeds many comments", FactoryGirl.create(:bike_with_comments).comments.first
    it_behaves_like "has many activities", :comment_on_bike
  end

  context 'associations' do
    it { is_expected.to be_embedded_in(:commentable).with_polymorphism }
    it { is_expected.to belong_to(:user) }
  end

  context 'fields' do
    it { is_expected.to have_field(:body     ).of_type(String) }
    it { is_expected.to have_field(:body_html).of_type(String) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  context 'class methods' do
  end

  context 'instance methods' do
    it 'to_s should return a truncated comment' do
      expect(subject.to_s).to eq subject.body.truncate 65
    end
  end
end


#   describe "notifications" do
#     before(:each) do
#       @user   = FactoryGirl.create(:homer)
#       @user_2 = FactoryGirl.create(:marge)
#     end
#
#     it "should have comments" do
#       expect(Answer.new.comments).to      eq []
#       expect(Article.new.comments).to     eq []
#       expect(Bike.new.comments).to        eq []
#       expect(Comment.new.comments).to     eq []
#       expect(Event.new.comments).to       eq []
#       expect(Question.new.comments).to    eq []
#       expect(RideRequest.new.comments).to eq []
#       expect(User.new.comments).to        eq []
#     end
#
#     it "should create bike comment notification" # do
#     #   @bike    = FactoryGirl.create(:bike, user: @user)
#     #   @comment = @bike.comments.build body: "D'oh", user: @user_2
#     #   Notification.should_receive(:fire).with([@user], @comment, 'bike_comment_created')
#     #   @comment.save!
#     # end
#
#     it "should create article comment notification" # do
#     #   @article = FactoryGirl.create(:article, user: @user)
#     #   @comment = @article.comments.build body: "D'oh", user: @user_2
#     #   Notification.should_receive(:fire).with([@user], @comment, 'article_comment_created')
#     #   @comment.save
#     # end
#
#     it "should create event comment notification" # do
#     #   @event    = FactoryGirl.create(:event, user: @user)
#     #   @comment  = @event.comments.build body: "D'oh", user: @user_2
#     #   Notification.should_receive(:fire).with([@user], @comment, 'event_comment_created')
#     #   @comment.save
#     # end
#   end
#
#   describe "validations" do
#     it { should validate_presence_of :body }
#     it { should validate_presence_of :user_id }
#   end
#
#   describe "attributes" do
#   end
#
#   describe "methods" do
#   end
# end
