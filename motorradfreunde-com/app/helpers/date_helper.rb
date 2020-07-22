module DateHelper

  def time_to_words(date, tag = :span)
    haml_tag tag, "", class: :time_to_words, data: {time: date.to_time.to_i}
  end

end
