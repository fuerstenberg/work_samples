module Concerns::Poi::Attributes::MetaInspector

  extend ActiveSupport::Concern

  included do
    attr_reader :meta_inspector_url

    after_validation :fetch_meta_information
  end

  def fetch_meta_information
    return if @meta_inspector_url.blank?
    page = MetaInspector.new @meta_inspector_url
    self.name        = page.best_title       if self.name.blank?
    self.description = page.best_description if self.description.blank?
    self.website     = page.url              if self.website.blank?
  end

  def meta_inspector_url=(url)
    @meta_inspector_url = url
  end

end
