RSpec.shared_examples "content/sortable" do |parameter|

  context 'associations' do
  end

  context 'fields' do
    it { is_expected.to have_field(:order).of_type(Integer).with_default_value_of(0) }
  end

  context 'class methods' do
    context 'sort_by_ids' do
      it 'should sort all items in the same order like the given ids param' do
        ids = [3, 2, 1]
        ids.each_with_index do |id, index|
          content = double "content #{id}"
          expect(described_class).to receive(:find).with(id).and_return content
          expect(content).to receive(:set).with order: index + 1
        end
        described_class.sort_by_ids ids
      end
    end
  end

  context 'methods' do
    context 'set_default_order' do
      before :each do
        allow(subject).to receive(:valid?).and_return true
        allow(subject).to receive(:release_for_all_screens).and_return true
      end

      it "should run after validation" do
        expect(subject).to receive(:set_default_order).once
        subject.save
      end

      it "should set the order field with the amount of contents for this customer" do
        allow(subject).to receive_message_chain('customer.contents.count').and_return 99
        subject.save
        expect(subject.order).to eq 99
      end
    end
  end
end
