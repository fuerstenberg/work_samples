RSpec.shared_examples "address" do |parameter|

  it "should respond to address" do
    expect(subject).to respond_to(:address)
  end

end


RSpec.shared_examples "addresses" do |parameter|

  it "should respond to address" do
    expect(subject).to respond_to(:address)
  end

end
