module Concerns::EmbedsManyComments

  extend ActiveSupport::Concern

  included do
    embeds_many :comments, as: :commentable, order: :created_at.asc

    accepts_nested_attributes_for :comments, allow_destroy: true, reject_if: lambda{|o| o["comment"].blank? }

    field :comments_count, type: Fixnum, default: 0
  end

  def commenters
    self.comments.map{|comment| [comment.user] + [comment.try(:commenters)]}.flatten.uniq
  end

end
