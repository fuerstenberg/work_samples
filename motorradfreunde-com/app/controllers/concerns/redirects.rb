module Concerns::Redirects

  extend ActiveSupport::Concern

  included do
    force_ssl if: :ssl_required?, domain: 'motorradfreunde.com', subdomain: 'www'

    before_action :redirect_to_motorradfreunde_com
  end

  private

  def on_article_reader_url?
    request.host.include?('motorrad-freunde.com') and controller_name == 'linked_articles' and action_name == 'show'
  end

  # DON'T REMOVE THIS CODE, BECAUSE GOOGLE API KEY WORKS ONLY FOR MOTORRADFREUNDE.COM
  def redirect_to_motorradfreunde_com
    target = "https://www.motorradfreunde.com/"
    if Rails.env.production? and not request.url.starts_with?(target) and not on_article_reader_url?
      redirect_to target, status: 301 # permanent redirect
    end
  end

  def ssl_required?
    Rails.env.production? and not on_article_reader_url?
  end

end
