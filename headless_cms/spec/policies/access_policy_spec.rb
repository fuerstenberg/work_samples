require "rails_helper"

RSpec.describe AccessPolicy do
  let(:user) { create :user }
  let(:customer) { create :customer }

  subject { described_class.new user }

  before do
    Current.customer = customer
  end

  it 'should initialize god role' do
    user.becomes_god!
    expect( subject.send(:applicable_roles).map(&:class) ).to eq [ GodRole ]
  end

  it 'should initialize admin role' do
    user.becomes_admin!
    expect( subject.send(:applicable_roles).map(&:class) ).to eq [ AdminRole ]
  end

  it 'should initialize owner role' do
    user.becomes_owner_of! customer: customer
    expect( subject.send(:applicable_roles).map(&:class) ).to eq [ OwnerRole ]
  end

  it 'should initialize editor role' do
    user.becomes_editor_of! customer: customer
    expect( subject.send(:applicable_roles).map(&:class) ).to eq [ EditorRole ]
  end

  it 'should initialize guest role' do
    user.roles.destroy_all
    expect( subject.send(:applicable_roles).map(&:class) ).to eq [ GuestRole ]
  end
end
