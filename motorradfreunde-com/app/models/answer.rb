class Answer

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::EmbedsManyComments
  include Concerns::HasManyActivities

  has_many :notifications, dependent: :destroy, as: :subject

  belongs_to :question, touch: true, counter_cache: true
  belongs_to :user

  field :body,      type: String
  field :body_html, type: String

  # TODO: auto_html
  # auto_html_for :body do
  #   html_escape
  #   redcarpet
  #   image
  #   youtube     width: 600, height: 450
  #   google_map  width: 600, height: 450, link_text: ""
  #   vimeo       width: 600, height: 450
  #   link        target: "_blank", rel: "nofollow"
  # end

  # TODO: acts_as_voteable

  validates_presence_of :body

  def to_s
    self.body.truncate 65
  end

end
