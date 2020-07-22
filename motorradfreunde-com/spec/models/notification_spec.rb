describe Notification do
  context 'general' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_timestamped_document }
  end

  context 'fire' do
    let(:homer) { FactoryGirl.create :homer }
    let(:marge) { FactoryGirl.create :marge }
    let(:bart)  { FactoryGirl.create :bart  }
    let(:lisa)  { FactoryGirl.create :lisa  }
    let(:maggy) { FactoryGirl.create :lisa  }

    context 'Comment' do
      it 'should fire on create for commentable.user (Marge)' do
        commentable = create :bike, user: marge
        expect { commentable.comments.create( attributes_for(:comment, user_id: homer.id)) }.to change{ marge.notifications.where(notification_type: 'comment.create').count }.from(0).to(1)
      end

      it 'should fire on create for all commenters (Bart)' do
        commentable = create :bike, user: marge
        commentable.comments.create( attributes_for(:comment, user_id: bart.id))
        expect { commentable.comments.create( attributes_for(:comment, user_id: homer.id)) }.to change{ bart.notifications.where(notification_type: 'comment.create').count }.from(0).to(1)
      end

      it 'should fire on create for all friends (Lisa) of commenter' do
        commentable = create :bike, user: marge
        homer.invite lisa
        lisa.approve homer
        expect { commentable.comments.create( attributes_for(:comment, user_id: homer.id)) }.to change{ lisa.notifications.where(notification_type: 'comment.create').count }.from(0).to(1)
      end
    end

    context 'Friendship' do
      it 'should fire on invite a user as friend (Lisa)' do
        expect { homer.invite lisa }.to change{ lisa.notifications.where(notification_type: 'user.friendship.invite').count }.from(0).to(1)
      end

      it 'should fire on accept a user as friend (Maggy)' do
        maggy.invite homer
        expect { homer.approve maggy }.to change{ maggy.notifications.where(notification_type: 'user.friendship.approve').count }.from(0).to(1)
      end
    end

    context 'Message' do
      it 'should fire on create for all conversation members' do
        conversation = Conversation.find_or_create_by_members homer, marge
        expect {
          create(:message, conversation: conversation, sender: homer)
        }.to change{
          marge.notifications.where(notification_type: 'message.create').count
        }.from(0).to(1)
      end

      it 'should fire on create for all conversation members except sender' do
        conversation = Conversation.find_or_create_by_members homer, marge
        expect {
          create(:message, conversation: conversation, sender: homer)
        }.to change{
          homer.notifications.where(notification_type: 'message.create').count
        }.by(0)
      end
    end

    context 'RideRequest' do
    end

    context 'User' do
      it 'should fire on greeting a user (Marge)' do
        expect { homer.greet marge }.to change{ marge.notifications.where(notification_type: 'user.greet').count }.from(0).to(1)
      end
    end
  end
end
