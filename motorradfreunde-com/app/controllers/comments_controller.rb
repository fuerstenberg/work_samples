class CommentsController < ApplicationController

  before_filter :set_commentable
  before_filter :set_comment, only: [:show, :destroy]

  def show
    redirect_to @comment.commentable
  end

  def new
    authorize! :create, Comment
    @comment = @commentable.comments.build user: current_user
  end

  def create
    authorize! :create, Comment
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, :notice => "Dein Kommentar wurde erfolgreich gespeichert!" }
        format.js
      else
        format.html { redirect_to :back, :alert => "Dein Kommentar wurde nicht gespeichert!" }
        format.js
      end
    end
  end

  def destroy
    authorize! :destroy, @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, :alert => "Dein Kommentar wurde entfernt!" }
      format.js
    end
  end

  private

  def set_commentable
    @commentable = Event.find_by    slug: params[:event_id]        if params[:event_id]
    @commentable = Bike.find_by     slug: params[:bike_id]         if params[:bike_id]
    @commentable = User.find_by     slug: params[:user_id]         if params[:user_id]
    @commentable = Comment.find     params[:comment_id]            if params[:comment_id]
    @commentable = Article.find_by  slug: params[:article_id]      if params[:article_id]
    @commentable = Answer.find      params[:answer_id]             if params[:answer_id]
    @commentable = RideRequest.find params[:ride_request_id]       if params[:ride_request_id]
    @commentable = Route.find_by    slug: params[:route_id]        if params[:route_id]
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit :commentable_id, :commentable_type, :body, :user
  end

end
