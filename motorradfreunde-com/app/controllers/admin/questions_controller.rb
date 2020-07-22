class Admin::QuestionsController < Admin::ApplicationController

  before_action :set_question

  def index
    @questions = Question.order(updated_at: :desc).page params[:page]
  end

  def show
  end

  # Todo: Already needed?
  def update
    if @question.update_attribute(:forum_id, params[:forum_id])
      render json: {id: params[:id], success: true}
    else
      render nothing: true
    end
  end

  def destroy
    @question.destroy if @question
    redirect_to [:admin, :questions]
  end

  private

  def set_question
    @question = Question.find(params[:id]) if params[:id]
  end

end
