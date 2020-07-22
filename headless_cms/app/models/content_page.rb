class ContentPage < ContentNode

  validate :must_have_parent

  private

  def must_have_parent
    errors.add(:parent, 'must be a content page or content tree') unless [ContentTree, ContentPage].include?(parent.class)
  end

end
