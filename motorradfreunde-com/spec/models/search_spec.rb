describe Mongoid::Search do
  context 'Bike' do
    it 'should find a bike' do
      object = create :bike
      expect(Bike.full_text_search(object.to_s).first).to eq object
    end
  end

  context 'Event' do
    it 'should find a event' do
      object = create :event
      expect(Event.full_text_search(object.to_s).first).to eq object
    end
  end

  context 'Poi' do
    it 'should find a poi' do
      object = create :poi
      expect(Poi.full_text_search(object.to_s).first).to eq object
    end
  end

  context 'Route' do
    it 'should find a route' do
      object = create :route
      expect(Route.full_text_search(object.to_s).first).to eq object
    end
  end

  context 'Video' do
    it 'should find a video' do
      object = create :video
      expect(Video.full_text_search(object.to_s).first).to eq object
    end
  end

  context 'User' do
    it 'should find a user' do
      object = create :user
      expect(User.full_text_search(object.to_s).first).to eq object
    end
  end
end
