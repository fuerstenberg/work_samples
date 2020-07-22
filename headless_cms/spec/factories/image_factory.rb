FactoryBot.define do

  factory :image do
    copyright {'Image by Homer Simpson'}
    file_hash {'210a3a8aa7e5b62447901f47a3f4b7d0'}
    title     {'Marge'}
    file { File.new(Rails.root + 'spec/support/test_500_500.png') }
  end

end
