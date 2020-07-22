# shared_examples "a mapable with a static map" do
#
#   context "attributes" do
#     it {
#       if subject.class.is_a?(Route)
#         expect(subject).to respond_to(:static_polyline)
#       end
#     }
#     it { expect(subject).to respond_to(:latitude) }
#     it { expect(subject).to respond_to(:longitude) }
#   end
#
#   context "associations" do
#     it { should have_one(:map).dependent(:destroy) }
#   end
#
#   context "callbacks" do
#     before(:each) do
#       allow(subject).to receive(:needs_static_map?).and_return(true)
#     end
#
#     it "should download_static_map on before save" do
#       expect(subject).to receive(:download_static_map).once
#       allow(subject).to receive(:valid?).and_return(true)
#       subject.save
#     end
#   end
#
#   context "class methods" do
#   end
#
#   context "instance methods" do
#
#     it "should have download_static_map" do
#       map = double("map")
#       expect(map).to receive(:user=).with(subject.user).once
#       expect(map).to receive(:is_map=).with(true).once
#       expect(map).to receive(:photo=).once
#       expect(subject).to receive(:build_map).once.and_return(map)
#       subject.download_static_map
#     end
#
#     it "should have needs_static_map?" do
#       expect(subject.needs_static_map?).to be false
#       subject.latitude, subject.longitude = 53, 13
#       expect(subject.needs_static_map?).to be true
#     end
#
#     it "should have static_map_url in Pois" do
#       if subject.is_a?(Poi)
#         subject.latitude, subject.longitude = 52, 13
#         expect(subject.download_static_map).to eq "http://maps.googleapis.com/maps/api/staticmap?sensor=false&size=640x320&zoom=10&markers=color%3Ared%7C52.0%2C13.0"
#       end
#     end
#
#     it "should have static_map_url in Routes" do
#       if subject.is_a?(Route)
#         subject.latitude, subject.longitude, subject.static_polyline = 52, 13, "any-static-polyline"
#         expect(subject.download_static_map).to eq "http://maps.googleapis.com/maps/api/staticmap?sensor=false&size=640x320&path=weight%3A3%7Ccolor%3Ablue%7Cenc%3Aany-static-polyline"
#       end
#     end
#
#     # it "should have static_map"
#
#   end
#
# end
