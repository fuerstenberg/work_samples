module Concerns::User::Newsletter

  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods

    def send_newsletter
      # User should be in DACH countries Deutschland, Österreich, Schweiz
      self.within_bounding_box([45.35706, 5.451101, 55.171359, 19.93206]).where("newsletter_sent_at < ? or newsletter_sent_at IS NULL", Time.now-7.days).order("RAND()").limit(50).to_a.each_with_index do |user, index|
        user.delay(run_at: index.minutes.from_now, queue: :newsletter, priority: 500).send_newsletter
      end
    end

  end

  def interesting_content_for_newsletter
    results = {}
    # Users nearby last 7 days
    results["users"] = User.with_photo.where(created_at: (Time.now-7.days..Time.now)).near_by(self, 50).limit(5).to_a
    # Events nearby next 7 days
    results["events"] = ::Event.where(start_at: (Time.now..Time.now+7.days)).near_by(self, 100).limit(5).to_a
    # Articles published last 7 days
    results["articles"] = ::Article.active.where(created_at: (Time.now-7.days..Time.now)).limit(5).to_a
    # Forum last 7 days
    results["questions"] = ::Question.where(created_at: (Time.now-7.days..Time.now)).where("answers_count > 9").order(answers_count: :desc).limit(5).to_a
    # Pois nearby last 7 days
    results["pois"] = ::Poi.where(created_at: (Time.now-7.days..Time.now)).near_by(self, 100).limit(5).to_a
    results
  end

  def send_newsletter
    content_objects = self.interesting_content_for_newsletter
    if (content_objects["users"].size > 0) and (content_objects.sum{|k,v| v.size } > 3)
      return UserMailer.newsletter(self, content_objects).deliver
    end
    false
  end

end
