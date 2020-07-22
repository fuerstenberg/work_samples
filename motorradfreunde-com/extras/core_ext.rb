# encoding: utf-8
class String
  
  def urlify
    str = self.dup
    {
      "ä" => "ae",
      "ö" => "oe",
      "ü" => "ue",
      "ß" => "ss",
      "Ä" => "Ae",
      "Ö" => "Oe",
      "Ü" => "Ue",
      "&" => "und"
    }.each do |key, value|
      str.gsub!(key, value)
    end
    str.parameterize
  end
  
end