class ContentField::AddressesController < ContentField::BaseController

  private

  def build(params = nil)
    @content_type.content_field_addresses.build params
  end

end
