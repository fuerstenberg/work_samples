class Statistic

  def self.overview
    [
      { name: "New users",           data: Statistic.new_users(60.days) },
      { name: "Current sign in at",  data: Statistic.users_current_sign_in_at(60.days) },
      { name: "Newsletter",          data: Statistic.users_sent_newsletters(60.days) }
    ].chart_json
  end

  def self.users_sent_newsletters(days = 7.days)
    (Date.today-days..Date.today).inject({}){|r,d| r[d] = 0; r}.merge(
      User.where("newsletter_sent_at > ?", Time.now - days).group("date(newsletter_sent_at)").count
    )
  end

  def self.objects(days = 30.days)
    empty_date_hash = (Date.today-days..Date.today).inject({}){|r,d| r[d] = 0; r}
    [Answer, Bike, Comment, Message, Photo, Question, RideRequest, Route].inject([]) do |r, c|
      r << { name: "#{c.to_s} (#{c.count})", data: empty_date_hash.merge(c.where("created_at > ?", Time.now - days).group("date(created_at)").count) }
      r
    end.chart_json
  end

  def self.objects_2(days = 30.days)
    empty_date_hash = (Date.today-days..Date.today).inject({}){|r,d| r[d] = 0; r}
    [Article, Event, Poi, User, Video].inject([]) do |r, c|
      r << { name: "#{c.to_s} (#{c.count})", data: empty_date_hash.merge(c.where("created_at > ?", Time.now - days).group("date(created_at)").count) }
      r
    end.chart_json
  end

  def self.photos
    Photo.group(:photogenic_type).count
  end

  def self.users_current_sign_in_at(days = 7.days)
    (Date.today-days..Date.today).inject({}){|r,d| r[d] = 0; r}.merge(
      User.where("current_sign_in_at > ?", Time.now - days).group("date(current_sign_in_at)").count
    )
  end

  def self.new_users(days = 7.days)
    (Date.today-days..Date.today).inject({}){|r,d| r[d] = 0; r}.merge(
      User.where("created_at > ?", Time.now - days).group("date(created_at)").count
    )
  end

end
