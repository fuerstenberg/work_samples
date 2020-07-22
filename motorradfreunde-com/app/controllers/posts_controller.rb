class PostsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:show]

  before_action :set_post, only: [:show]

  def show
    authorize! :read, @post
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:id]) rescue Post.find(params[:id])
  end

end
