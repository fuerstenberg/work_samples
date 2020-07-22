module LinkedArticlesHelper

  def article_reader_url(linked_article)
    if Rails.env.production?
      linked_article_url protocol: 'http', host: 'www.motorrad-freunde.com', id: linked_article.slug
    else
      url_for linked_article
    end
  end

end
