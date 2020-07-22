RSpec.shared_examples "shared/content_type" do |parameter|

  context 'associations' do
    it { is_expected.to embed_many(:content_fields           ).of_type(ContentField::Base     ).stored_as("content_fields") }
    it { is_expected.to embed_many(:content_field_booleans   ).of_type(ContentField::Boolean  ).stored_as("content_fields") }
    it { is_expected.to embed_many(:content_field_decimals   ).of_type(ContentField::Decimal  ).stored_as("content_fields") }
    it { is_expected.to embed_many(:content_field_integers   ).of_type(ContentField::Integer  ).stored_as("content_fields") }
    it { is_expected.to embed_many(:content_field_long_texts ).of_type(ContentField::LongText ).stored_as("content_fields") }
    it { is_expected.to embed_many(:content_field_short_texts).of_type(ContentField::ShortText).stored_as("content_fields") }
    it { is_expected.to embed_many(:content_field_times      ).of_type(ContentField::Time     ).stored_as("content_fields") }
  end

  context 'fields' do
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
    it { is_expected.to have_field(:auto_publish ).of_type(Mongoid::Boolean).with_default_value_of(false) }
    it { is_expected.to have_field(:description  ).of_type(String) }
    it { is_expected.to have_field(:name         ).of_type(String) }
    it { is_expected.to have_field(:type         ).of_type(String) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_uniqueness_of(:type) }
  end

  context "methods" do
    context "allowed_field_ids" do
      it "should return an array of allowed field ids" do
        subject.content_fields.build field_id: "title"
        subject.content_fields.build field_id: "description"
        expect(subject.allowed_field_ids).to eq [:title, :description]
      end
    end
  end
end
