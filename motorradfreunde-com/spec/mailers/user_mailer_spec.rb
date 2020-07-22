require "spec_helper"

describe UserMailer do

  before(:each) do
    User.delete_all
    @user   = FactoryGirl.create :user
    @user_2 = FactoryGirl.create :user
  end

  describe 'notification_mail' do
    it "should have a reciepient" do
      notification = FactoryGirl.create(:notification, :subject => FactoryGirl.create(:comment, commentable: FactoryGirl.create(:event)), :user => @user)
      mail = UserMailer.notification_mail(notification)
      pending
      # mail.to.first.should == @user.email
    end

    it "should have body with link and text" do
      @bike = FactoryGirl.create(:bike, :user => @user)
      FactoryGirl.create(:comment, :commentable => @bike, :user => @user_2)
      mail = UserMailer.notification_mail(@user.notifications.first)
      expect(mail.body).to include "http://www.motorradfreunde.com/account/notifications"
      expect(mail.body).to include("Hallo #{@user}")
      expect(mail.body).to include("du hast eine neue Benachrichtigung von #{@user_2} erhalten.")
    end
  end

end
