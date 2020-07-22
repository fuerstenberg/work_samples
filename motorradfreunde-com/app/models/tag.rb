# class Tag < ActsAsTaggableOn::Tag
#
#   def name_plural
#     read_attribute(:name_plural).present? ? read_attribute(:name_plural) : self.name
#   end
#
#   def to_param
#     if self.poi_category?
#       "#{self.id}-#{self.name_plural.parameterize_with_umlauts}"
#     else
#       "#{self.id}-#{self.name.parameterize_with_umlauts}"
#     end
#   rescue
#     super
#   end
#
#   def to_s
#     self.name
#   end
#
# end
