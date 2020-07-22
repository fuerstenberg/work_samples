require "rails_helper"

RSpec.describe GodRole do
  let(:user) { create :user }
  let(:customer) { create :customer }
  subject { AccessPolicy.new user }

  before do
    user.becomes_god!
  end

  it { expect( subject.can? :read,    Address           ).to be true }
  it { expect( subject.can? :create,  Address           ).to be true }
  it { expect( subject.can? :update,  Address           ).to be true }
  it { expect( subject.can? :destroy, Address           ).to be true }

  it { expect( subject.can? :read,    Content           ).to be true }
  it { expect( subject.can? :create,  Content           ).to be true }
  it { expect( subject.can? :update,  Content           ).to be true }
  it { expect( subject.can? :destroy, Content           ).to be true }

  it { expect( subject.can? :read,    ContentField      ).to be true }
  it { expect( subject.can? :create,  ContentField      ).to be true }
  it { expect( subject.can? :update,  ContentField      ).to be true }
  it { expect( subject.can? :destroy, ContentField      ).to be true }

  it { expect( subject.can? :read,    ContentType       ).to be true }
  it { expect( subject.can? :create,  ContentType       ).to be true }
  it { expect( subject.can? :update,  ContentType       ).to be true }
  it { expect( subject.can? :destroy, ContentType       ).to be true }

  it { expect( subject.can? :read,    Customer          ).to be true }
  it { expect( subject.can? :create,  Customer          ).to be true }
  it { expect( subject.can? :update,  Customer          ).to be true }
  it { expect( subject.can? :destroy, Customer          ).to be true }

  it { expect( subject.can? :read,    Document          ).to be true }
  it { expect( subject.can? :create,  Document          ).to be true }
  it { expect( subject.can? :update,  Document          ).to be true }
  it { expect( subject.can? :destroy, Document          ).to be true }

  it { expect( subject.can? :read,    GlobalContentType ).to be true }
  it { expect( subject.can? :create,  GlobalContentType ).to be true }
  it { expect( subject.can? :update,  GlobalContentType ).to be true }
  it { expect( subject.can? :destroy, GlobalContentType ).to be true }

  it { expect( subject.can? :read,    Image             ).to be true }
  it { expect( subject.can? :create,  Image             ).to be true }
  it { expect( subject.can? :update,  Image             ).to be true }
  it { expect( subject.can? :destroy, Image             ).to be true }

  it { expect( subject.can? :read,    Release           ).to be true }
  it { expect( subject.can? :create,  Release           ).to be true }
  it { expect( subject.can? :update,  Release           ).to be true }
  it { expect( subject.can? :destroy, Release           ).to be true }

  it { expect( subject.can? :read,    Role              ).to be true }
  it { expect( subject.can? :create,  Role              ).to be true }
  it { expect( subject.can? :update,  Role              ).to be true }
  it { expect( subject.can? :destroy, Role              ).to be true }

  it { expect( subject.can? :read,    Screen            ).to be true }
  it { expect( subject.can? :create,  Screen            ).to be true }
  it { expect( subject.can? :update,  Screen            ).to be true }
  it { expect( subject.can? :destroy, Screen            ).to be true }

  it { expect( subject.can? :read,    User              ).to be true }
  it { expect( subject.can? :create,  User              ).to be true }
  it { expect( subject.can? :update,  User              ).to be true }
  it { expect( subject.can? :destroy, User              ).to be true }

  it { expect( subject.can? :read,    Video             ).to be true }
  it { expect( subject.can? :create,  Video             ).to be true }
  it { expect( subject.can? :update,  Video             ).to be true }
  it { expect( subject.can? :destroy, Video             ).to be true }

end
