# encoding: utf-8

module CustomDateHelper

  def humanized_date(date)
    date = l @ride_request.start_at.to_date, format: :longer
    day = if @ride_request.start_at.to_date == Date.today
      "(heute)"
    elsif @ride_request.start_at.to_date == (Date.today + 1.day)
      "(morgen)"
    elsif @ride_request.start_at.to_date == (Date.today + 2.days)
      "(übermorgen)"
    end
    <<-DATE
      #{date} #{day}
    DATE
  end


end
