# encoding: utf-8
class AdminMailer < ActionMailer::Base

  default from: "\"Motorradfreunde.com\" <info@motorradfreunde.com>"
  default to:   "rene.fuerstenberg@gmail.com>"

  def report_to_admin(object)
    @object = object
    mail subject: "Ein #{object.class.to_s} wurde erstellt oder geändert, bitte überprüfen!"
  end

end
