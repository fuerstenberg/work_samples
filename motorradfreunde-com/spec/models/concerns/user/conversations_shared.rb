shared_examples "a conversation member or administrator" do
  context 'general' do
  end

  context 'concerns' do
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
    it 'should return all conversations' do
      conversation = create :conversation
      user = conversation.members.first
      expect(user.conversations).to include conversation
    end
  end
end
