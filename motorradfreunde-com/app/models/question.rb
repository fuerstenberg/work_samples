class Question

  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::EmbedsManyComments
  include Concerns::HasImpressions
  include Concerns::HasMetaMethods
  include Concerns::HasManyActivities

  has_many :answers,    dependent: :destroy

  belongs_to :forum
  belongs_to :user

  field :answers_count,     type: Integer
  field :body_html,         type: String
  field :body,              type: String
  field :highlight,         type: Boolean, default: false
  field :title,             type: String

  validates :body,      presence: true
  validates :title,     presence: true

  acts_as_url :title, url_attribute: :slug

  # TODO: auto_html_for
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

  def involved_people
    # [self.user, self.answerers, self.commenters].flatten.uniq
    [self.user].flatten.uniq
  end

  def to_param
    slug
  end

  def to_s
    title
  end

  def votes_count
    self.answers.sum &:votes_count rescue nil
  end

end
