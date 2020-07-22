require "rails_helper"

RSpec.describe ContentSerializer, type: :serializer do

  context "Individual Resource Representation" do
    let(:content) { create :homer_simpson }
    let(:serializer) { ContentSerializer.new(content) }

    subject do
      expect(content).to be_valid
      JSON.parse(serializer.to_json) # ["content"]
    end

    it "has a id" do
      expect(subject["id"]).to eql(content.id.to_s)
    end

    describe '#assets' do
      context 'for images' do
        let(:image_content) { create :an_image }
        let(:serializer) { ContentSerializer.new(image_content) }

        subject do
          expect(content).to be_valid
          JSON.parse(serializer.to_json) # ["content"]
        end

        it "returns images within assets" do
          result = image_content.all_assets.map do |asset|
            asset.url_hash.stringify_keys
          end
          expect(subject["assets"]).to eql(result)
        end
      end

      context 'for videos' do
        let(:video_content) { create :a_video }
        let(:serializer) { ContentSerializer.new(video_content) }

        subject do
          expect(content).to be_valid
          JSON.parse(serializer.to_json) # ["content"]
        end

        it "returns videos within assets" do
          result = video_content.all_assets.map do |asset|
            asset.url_hash.stringify_keys
          end
          expect(subject["assets"]).to eql(result)
        end
      end
    end

    it "has attributes from content type" do
      content.content_type.content_fields.each do |content_field|
        if content_field.is_a?(ContentField::Time)
          expect(Time.parse(subject[content_field.field_id.to_s])).to be_between(content[content_field.field_id.to_s]-1.second, content[content_field.field_id.to_s]+1.second)
        elsif content_field.is_a?(ContentField::Image)
          if content_field.has_many?
            subject[content_field.field_id.to_s].each_with_index do |image, index|
              expect(image.symbolize_keys.keys).to eql( ImageSerializer.new(content.send(content_field.field_id.to_s).to_a[index]).as_json.keys )
            end
          else
            # expect(subject[content_field.field_id.to_s].symbolize_keys.keys).to eql( ImageSerializer.new(content.send(content_field.field_id.to_s)).as_json.keys )
          end
        else
          expect(subject[content_field.field_id.to_s]).to eql(content[content_field.field_id.to_s])
        end
      end
    end

    it "has a createdAt" do
      expect(subject["createdAt"]).to eql content.created_at
    end

    it "has a updatedAt" do
      expect(subject["updatedAt"]).to eql content.updated_at
    end
  end

end
