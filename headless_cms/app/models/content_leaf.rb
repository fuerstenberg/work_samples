class ContentLeaf < ContentNode

  validate :must_have_parent

  private

  def must_have_parent
    errors.add(:parent, 'must be a content page, content list or content tree') unless [ContentList, ContentTree, ContentPage].include?(parent.class)
  end

end
