class Tag
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  has_many :taggings

  field :name, type: String
end

class Tagging
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  belongs_to :tag
end

class TagImporterService

  def initialize
    # import_poi_tags
    import_user_tags
  end

  def import_poi_tags
    Tagging.where(taggable_type: 'Poi').all.each do |tagging|
      if object = tagging.taggable_type.constantize.find(tagging.taggable_id)
        tag = tagging.tag
        # debugger
        types = object.types
        types << tag.name
        object.set types: types.uniq
        # object.types << tag.name
        # object.save validate: false
        puts "#{tag} -> #{tag.name}"
      end
    end
  end

  def import_user_tags
    {
      "genders" => "gender",
      "owns_motorcycle" => "has_own_motorcycle",
      "backseat" => "status_for_backseat",
      "relationship" => "status_for_relationship"
    }.each do |context, new_context|
      Tagging.where(taggable_type: 'User', context: context).all.each do |tagging|
        if object = tagging.taggable_type.constantize.find(tagging.taggable_id)
          tag = tagging.tag
          object.set new_context => tag.name
        end
      end
    end

    {
      "clothing" => "favorite_clothing",
      "drive_types" => "favorite_drive_type",
      "driving_styles" => "favorite_driving_style",
      "interested_in_gender" => "interested_in_gender",
      "rides" => "status_as_biker",
      "rides_with_other" => "status_of_social_behavior",
    }.each do |context, new_context|
      Tagging.where(taggable_type: 'User', context: context).all.each do |tagging|
        if object = tagging.taggable_type.constantize.find(tagging.taggable_id)
          tag = tagging.tag
          # types = object.types
          # types << tag.name
          if new_context == "status_as_biker"
            values = [(tag.name == 'yes' ? 'driver' : 'passenger')]
          else
            values = [object[new_context]] + [tag.name]
          end

          object.set new_context => values.flatten.uniq
          # object.types << tag.name
          # object.save validate: false
          # puts "#{tag} -> #{tag.name}"
        end
      end
    end
  end

end
