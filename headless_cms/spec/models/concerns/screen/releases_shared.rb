RSpec.shared_examples "Concerns::Screen::Releases" do |parameter|
  let(:screen) { create :screen }

  context 'methods' do
    it 'should receive destroy_content_releases' do
      expect(screen).to receive(:destroy_content_releases).once
      screen.destroy
    end
  end

end
