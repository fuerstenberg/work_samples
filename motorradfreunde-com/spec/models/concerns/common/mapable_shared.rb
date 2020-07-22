# shared_examples "a mapable" do
#
#   context "attributes" do
#     it { expect(subject).to respond_to(:address) }
#     it { expect(subject).to respond_to(:city) }
#     it { expect(subject).to respond_to(:country) }
#     it { expect(subject).to respond_to(:country_code) }
#     it { expect(subject).to respond_to(:full_address) }
#     it { expect(subject).to respond_to(:latitude) }
#     it { expect(subject).to respond_to(:longitude) }
#     it { expect(subject).to respond_to(:postal_code) }
#     it { expect(subject).to respond_to(:route) }
#     it { expect(subject).to respond_to(:server_side_geocoding) }
#     it { expect(subject).to respond_to(:state) }
#     it { expect(subject).to respond_to(:state_code) }
#     it { expect(subject).to respond_to(:street_number) }
#   end
#
#   context "callbacks" do
#     before(:each) do
#       allow(subject).to receive(:mapable_address_changed?).and_return(true)
#       allow(subject).to receive(:mapable_latitude_or_longitude_changed?).and_return(true)
#       # allow(subject).to receive(:needs_static_map?).and_return(true)
#     end
#
#     it "should geocode on before validation" do
#       expect(subject).to receive(:geocode).once
#       subject.valid?
#     end
#
#     it "should reverse_geocode on before validation" do
#       expect(subject).to receive(:reverse_geocode).once
#       subject.valid?
#     end
#   end
#
#   context "class methods" do
#     it "search in bounds" do
#       table = subject.class.to_s.underscore.pluralize
#       expect(subject.class.in_bounds("1,2,3,4").to_sql).to be_start_with "SELECT `#{table}`.* FROM `#{table}`  WHERE (latitude>1.0 AND latitude<3.0 AND longitude>2.0 AND longitude<4.0)"
#       expect(subject.class.in_bounds("4,3,2,1").to_sql).to be_start_with "SELECT `#{table}`.* FROM `#{table}`  WHERE (latitude>4.0 AND latitude<2.0 AND (longitude<1.0 OR longitude>3.0))"
#     end
#   end
#
#   context "instance methods" do
#     it "should have geocoded?" do
#       subject.latitude = nil
#       subject.longitude = nil
#       expect(subject).to_not have_geo
#       subject.latitude = 56.789
#       subject.longitude = 12.345
#       expect(subject).to have_geo
#     end
#
#     it "should return street_address_and_street_number" do
#       subject.address[:street_address] = nil
#       subject.address[:street_number] = "1"
#       expect(subject.street_address_and_street_number).to be_nil
#       subject.address[:street_address] = "Hauptstraße"
#       expect(subject.street_address_and_street_number).to eq "Hauptstraße 1"
#     end
#
#     it "should have geocodeable_address" do
#       expect(subject.geocodeable_address).to eq ""
#       subject.street_address = "any-street"
#       subject.street_number = "1"
#       expect(subject.geocodeable_address).to eq "any-street 1"
#       subject.full_address = "any-address"
#       expect(subject.geocodeable_address).to eq "any-address"
#     end
#
#     it "should have postal_code_and_city_and_state_and_country" do
#       subject.postal_code = "99988"
#       subject.city = "Springfield"
#       subject.state = "Springfield" # should remove state info, because it is the same like city
#       subject.country = "USA"
#       expect(subject.postal_code_and_city_and_state_and_country).to eq "99988 Springfield, USA"
#     end
#
#     it "should have postal_code_and_city" do
#       subject.postal_code = "99988"
#       subject.city = "Springfield"
#       expect(subject.postal_code_and_city_and_state_and_country).to eq "99988 Springfield"
#     end
#
#     it "should have complete_address" do
#       subject.street_address = "any-street"
#       subject.street_number = "1"
#       subject.postal_code = "99988"
#       subject.city = "Springfield"
#       subject.state = "Springfield" # should remove state info, because it is the same like city
#       subject.country = "USA"
#       expect(subject.complete_address).to eq "any-street 1, 99988 Springfield, USA"
#     end
#
#     # it "should geocode by ip" do
#     #   user = User.new current_sign_in_ip: "79.193.144.13"
#     #   user.valid?
#     #   expect(user.address).to eq "Germany,16321 Rüdnitz"
#     #   expect(user.latitude.round).to == 53
#     #   expect(user.longitude.round).to == 14
#     # end
#
#     it "should geocode by lat lng" do
#       o = subject.class.new latitude: "52.5163336", longitude: "13.4815529"
#       o.valid?
#       expect(o.address).to eq({
#         "city"              => "Berlin",
#         "country"           => "Deutschland",
#         "country_code"      => "DE",
#         "formatted_address" => "Normannenstraße 39A, 10367 Berlin, Deutschland",
#         "latitude"          => 52.5163315,
#         "longitude"         => 13.4815944,
#         "postal_code"       => "10367",
#         "precision"         => "ROOFTOP",
#         "province"          => "Berlin",
#         "province_code"     => "Berlin",
#         "route"             => "Normannenstraße",
#         "state"             => "Berlin",
#         "state_code"        => "Berlin",
#         "street_address"    => "39A Normannenstraße",
#         "street_number"     => "39A",
#         "sub_state"         => nil,
#         "sub_state_code"    => nil
#       })
#     end
#   end
#
# end
