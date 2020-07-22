class Admin::AnswersController < Admin::ApplicationController

  before_action :set_answer

  def index
    @answers = Answer.order(updated_at: :desc).page params[:page]
  end

  def destroy
    @answer.destroy if @answer
    redirect_to [:admin, :answers]
  end

  private

  def set_answer
    @answer = Answer.find(params[:id]) if params[:id]
  end

end
