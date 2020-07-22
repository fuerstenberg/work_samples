class VotesController < ApplicationController

  before_filter :find_voteable

  def update
    authorize! :create, Vote
    if params[:for]
      current_user.vote_exclusively_for @voteable
    elsif params[:against]
      current_user.vote_exclusively_against @voteable
    end
    redirect_to :back
  end

  private

  def find_voteable
    @voteable = Question.find_by(slug: params[:question_id]) if params[:question_id]
    @voteable = Answer.find(params[:answer_id]) if params[:answer_id]
  end

end
