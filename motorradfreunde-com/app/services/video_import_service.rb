# TODO: build video importer
# youtube_it is deprecated
# alternative gems:
# https://github.com/Fullscreen/yt
# https://github.com/thibaudgg/video_info

class VideoImportService

  def initialize(query = 'Motorrad')
    @key = Rails.application.secrets.youtube['key']
    @page = 0
    @query = query

    import
  end

  private

  attr_reader :key
  attr_reader :page
  attr_reader :query

  def import
    client = YouTubeIt::Client.new(dev_key: @key)
    client.videos_by(query: @query, page: @page)
  end

  # def self.import_from_youtube(query = 'Motorrad', page = nil)
  #   client = YouTubeIt::Client.new(dev_key: API_KEY)
  #   if page
  #     client.videos_by(query: query, page: page).videos.each do |video|
  #       self.import_youtube_video video
  #     end
  #   else
  #     results = client.videos_by(query: query)
  #     pages = results.total_pages <= 40 ? results.total_pages : 40
  #     (1..pages).each do |page|
  #       self.import_from_youtube query, page
  #       sleep 5
  #     end
  #   end
  # end
  #
  # def self.import_youtube_video(video)
  #   new_video = Video.where(unique_id: video.unique_id).first_or_initialize
  #   if video.access_control["embed"] == "allowed" and video.access_control["autoPlay"] == "allowed"
  #     new_video.youtube_video_id          = video.video_id
  #     new_video.youtube_categories        = video.categories.map(&:label)
  #     new_video.title                     = video.title
  #     new_video.author_name               = video.author.name rescue ""
  #     new_video.author_uri                = video.author.uri rescue ""
  #     new_video.description               = video.description
  #     new_video.duration                  = video.duration
  #     new_video.youtube_rating_likes      = video.rating.likes rescue 0
  #     new_video.youtube_rating_dislikes   = video.rating.dislikes rescue 0
  #     new_video.youtube_rating_count      = video.rating.rater_count rescue 0
  #     new_video.youtube_rating_average    = video.rating.average rescue 0
  #     new_video.player_url                = video.player_url
  #     new_video.youtube_view_count        = video.view_count # integer
  #     new_video.save
  #   end
  # end

end
