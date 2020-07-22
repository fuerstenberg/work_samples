require "rails_helper"

RSpec.describe "Login as", type: :feature do

  context "anonymous user" do
    it "should NOT be possible"
    it "should NOT show a registration view"
  end

  context "admin" do
    it "should be possible"
    it "should show a homepage"
  end

  context "editor" do
    it "should be possible"
    it "should show a homepage"
  end

end
