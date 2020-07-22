require "rails_helper"

RSpec.describe VideoSerializer, type: :serializer do

  context "Individual Resource Representation" do
    let(:resource) { build(:video) }
    let(:serializer) { VideoSerializer.new(resource) }

    subject do
      expect(resource).to be_valid
      JSON.parse(serializer.to_json)
    end

    it "has an id" do
      expect(subject["id"]).to eql(resource.id.to_s)
    end

    it 'has a content type field' do
      expect(subject['content_type']).to eql('video/quicktime')
    end

    it 'has a copyright field' do
      expect(subject['copyright']).to eql('this a legal warning and copyright hint')
    end

    it 'has a file_hash field' do
      expect(subject['file_hash']).to eql('any file hash to check uniqueness of file content')
    end

    it 'has a title field' do
      expect(subject['title']).to eql('some video description')
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
