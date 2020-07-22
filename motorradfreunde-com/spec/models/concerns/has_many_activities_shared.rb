shared_examples 'has many activities' do |args|
  describe 'general' do
    it 'should track public activity on create' do
      obj = FactoryGirl.build *args
      expect(ActivityBaseService).to receive(:process).with(object: obj, on: :create).once
      obj.save
    end

    it 'should track public activity on update' do
      obj = FactoryGirl.build *args
      obj.save
      expect(ActivityBaseService).to receive(:process).with(object: obj, on: :update).once

      if obj.is_a?(Bike)
        obj.update_attributes(model: 'K1300R')
      elsif obj.is_a?(Comment)
        obj.update_attributes(body: 'Change the whole comment body...')
      elsif obj.is_a?(Event)
        obj.update_attributes(title: 'Change the whole event title...')
      elsif obj.is_a?(Image)
        obj.update_attributes(cover: true)
      elsif obj.is_a?(Poi)
        obj.update_attributes(name: 'Change whole poi name')
      elsif obj.is_a?(Post)
        obj.update_attributes(title: 'Change whole title')
      elsif obj.is_a?(RideRequest)
        obj.update_attributes(start_at: Time.now)
      elsif obj.is_a?(Route)
        obj.update_attributes(name: 'Change whole route title...')
      elsif obj.is_a?(User)
        obj.update_attributes(name: 'Apu Nahasapemapetilon')
      elsif obj.is_a?(Video)
        obj.update_attributes(title: 'A crazy video')
      end
    end
  end
end
