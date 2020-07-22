class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def index
  end

  def banners
    @banners = Dir.glob(File.join(Rails.root.to_s, "app", "assets", "images", "banners", "*")).select{|f| [".gif", ".png", ".jpg"].include?(File.extname(f))}
    @banners = @banners.map{|f| "banners/#{File.basename(f)}"}
  end

  def feedback
  end

  def help
  end

  def homepage
    if current_user
      redirect_to [:dashboard, current_user]
    else
      render :homepage
    end
  end

  def impress
  end

  def partner
  end

  def terms
  end

  def welcome
  end

end
