class LinkedArticle < Article

  include Concerns::IsFeedItem

  acts_as_url :title, url_attribute: :slug # needed here instead of inherit from article, because the parse method must be called before

  def next
    self.class.where(:created_at.gt => created_at).order(created_at: :desc).first
  end

  def prev
    self.class.where(:created_at.lt => created_at).order(created_at: :desc).first
  end

  def to_s
    title
  end

end
