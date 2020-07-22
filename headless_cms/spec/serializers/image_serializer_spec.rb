require "rails_helper"

RSpec.describe ImageSerializer, type: :serializer do

  context "Individual Resource Representation" do
    let(:resource) { build(:image) }
    let(:serializer) { ImageSerializer.new(resource) }

    subject do
      expect(resource).to be_valid
      JSON.parse(serializer.to_json)
    end

    it "has an id" do
      expect(subject["id"]).to eql(resource.id.to_s)
    end

    it 'has a content type field' do
      expect(subject['content_type']).to eql('image/png')
    end

    it 'has a copyright field' do
      expect(subject['copyright']).to eql('Image by Homer Simpson')
    end

    it 'has a file_hash field' do
      expect(subject['file_hash']).to eql('210a3a8aa7e5b62447901f47a3f4b7d0')
    end

    it 'has a title field' do
      expect(subject['title']).to eql('Marge')
    end

    it 'has a file field' do
      result = ( [:original] + resource.file.versions.keys ).inject({}) do |files, version|
        if version == :original
          files[version] = resource.file.url
        else
          files[version] = resource.file.url(version)
        end
        files
      end

      expect(subject['files']).to eql( result.stringify_keys )
    end
  end
end
