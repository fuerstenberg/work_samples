shared_examples 'embeds one address' do |parent|
  context 'general' do
    it { is_expected.to have_index_for('address.coordinates' => '2dsphere').with_options({ min: -180, max: 180 }) }
  end

  context 'concerns' do
  end

  context 'associations' do
    it { is_expected.to embed_one(:address).with_polymorphism.with_cascading_callbacks.with_autobuild }
  end

  context 'fields' do
    it { is_expected.to accept_nested_attributes_for(:address) }
  end

  context 'validations' do
  end

  context 'callbacks' do
    it 'should geocode if latitude and longitude are not set' do
      parent.address.attributes = attributes_for :address
      parent.address.coordinates = []
      # expect(parent.address).to receive(:geocode)
      # debugger
      expect(parent.valid?).to be true
      expect(parent.address.prevent_geocoding?).to be false
    end

    it 'should not geocode if latitude and longitude are set' do
      parent.address.attributes = attributes_for :address
      parent.address.latitude  = 52.1234
      parent.address.longitude = 13.1234
      expect(parent.address).to_not receive(:geocode)
      parent.valid?
    end

    it 'should set coordinates if latitude and longitude used' do
      coordinates = [12, 53]
      parent.address.latitude  = coordinates[1]
      parent.address.longitude = coordinates[0]
      parent.address.valid?
      expect(parent.address.coordinates).to eq coordinates
    end

    # it 'should call download_static_map before_save' do
    #   parent.address.attributes = attributes_for :address
    #   allow(parent.address).to receive(:geocoded?).and_return true
    #   allow(parent.address).to receive(:changed?).and_return true
    #   expect(parent.address).to receive(:download_static_map)
    #   parent.address.save
    # end
  end

  context 'class methods' do
  end

  context 'instance methods' do
    it 'formatted_address' do
      if parent.kind_of?(User)
        expect(parent.formatted_address).to eq parent.formatted_address_without_street
      else
        expect(parent.formatted_address).to eq parent.formatted_address_with_street
      end
    end

    it 'formatted_address_with_street' do
      expect(parent.formatted_address_with_street).to eq([
        parent.formatted_street,
        parent.formatted_zip_city,
        parent.formatted_state,
        parent.formatted_country,
      ].compact)
    end

    it 'formatted_address_without_street' do
      expect(parent.formatted_address_without_street).to eq([
        parent.formatted_zip_city,
        parent.formatted_state,
        parent.formatted_country,
      ].compact)
    end

    it 'formatted_country' do
      expect(parent.formatted_country).to eq parent.address.country
    end

    it 'formatted_state' do
      expect(parent.formatted_state).to eq parent.address.state
    end

    it 'formatted_street' do
      expect(parent.formatted_street).to eq parent.address.street
    end

    it 'formatted_zip_city' do
      expect(parent.formatted_zip_city).to eq [ parent.address.try(:zip), parent.address.try(:city) ].compact.join(' ')
    end

    it 'geocoded? should be delegated to address' do
      expect(parent.address).to receive :geocoded?
      parent.geocoded?
    end

    it 'to_coordinates should be delegated to address' do
      expect(parent.address).to receive :to_coordinates
      parent.to_coordinates
    end

    it 'update_from_request'

  end
end
