RSpec.shared_examples "content/releases" do |parameter|

  context 'associations' do
    it { is_expected.to embed_many :releases }
  end

  context 'fields' do
  end

  context 'scopes' do
    it 'released_for_screen should only return released content for a screen'
  end

  context 'methods' do
    context 'auto_publish?' do
      it 'should delegate to content_type' do
        subject.content_type = ContentType.new
        expect(subject.content_type).to receive :auto_publish?
        subject.auto_publish?
      end
    end

    context 'release_for_all_screens' do
      before :each do
        allow(subject).to receive(:valid?).and_return true
        allow(subject).to receive(:set_default_order)
      end

      it 'should be called when auto_publish in content_type enabled' do
        expect(subject).to receive(:auto_publish?).once.and_return true
        expect(subject).to receive(:release_for_all_screens).once
        subject.save
      end

      it 'should not be called when auto_publish in content_type enabled' do
        expect(subject).to receive(:auto_publish?).once.and_return false
        expect(subject).to_not receive(:release_for_all_screens)
        subject.save
      end

      it 'should not be called when content is already persisted' do
        allow(subject).to receive(:new_record?).and_return false
        expect(subject).to_not receive(:release_for_all_screens)
        subject.save
      end

      it 'should create releases for all screens' do
        screen = Screen.new
        expect(subject).to receive(:auto_publish?).once.and_return true
        expect(subject).to receive_message_chain('customer.screens.each').and_yield screen
        subject.save
        expect(subject.releases.first).to be_valid
        expect(subject.releases.first.screen).to eq screen
        expect(subject.releases.count).to eq 1
      end
    end
  end
end
