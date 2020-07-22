class Forum::AnswersController < ApplicationController

  before_filter :authenticate_user!

  def show
    redirect_to Answer.find(params[:id]).question
  rescue
    redirect_to :questions
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build answer_params
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: I18n.t("controller.answer.create.notice")
    else
      render template: "questions/show", alert: I18n.t("controller.answer.create.alert")
    end
  end

  def destroy
    @answer = current_user.answers.find params[:id]
    @answer.destroy
    redirect_to :answers, notice: I18n.t("controller.answer.destroy.notice")
  end

  private

  def answer_params
    params.require(:answer).permit :question_id, :body, :user_id, :user
  end

end
