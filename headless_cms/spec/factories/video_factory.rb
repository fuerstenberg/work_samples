FactoryBot.define do

  factory :video do
    copyright {'this a legal warning and copyright hint'}
    file {File.open("spec/support/test.mov")}
    file_hash {'any file hash to check uniqueness of file content'}
    title {'some video description'}
  end

end
