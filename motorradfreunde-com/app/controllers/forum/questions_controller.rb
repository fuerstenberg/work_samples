class Forum::QuestionsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  after_filter :count_impression, only: :show

  has_scope :order, default: "answers_asc", only: :show do |controller, scope, value|
    case value
    when 'answers_asc'
      scope.order('answers.created_at' => :asc)
    when 'answers_desc'
      scope.order('answers.created_at' => :desc)
    else
      scope
    end
  end

  def index
    @questions =  Question
    if params[:query]
      @questions = @questions.search params[:query], page: params[:page]
    else
      @questions = @questions.order(updated_at: :desc).page(params[:page]).per(30)
    end
  end

  def show
    @question = apply_scopes(Question).find_by(slug: params[:id]) rescue apply_scopes(Question).find_by(slug: params[:id][ params[:id].index('-')+1..-1 ])
  rescue Mongoid::Errors::DocumentNotFound => e
    render nothing: true, status: 301
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build question_params
    if @question.save
      redirect_to [:forum, @question], :notice => I18n.t("controller.question.create.notice")
    else
      render :new
    end
  end

  def edit
    @question = current_user.questions.find_by slug: params[:id]
  end

  def update
    @question = current_user.questions.find_by slug: params[:id]
    if @question.update_attributes(question_params)
      redirect_to [:forum, @question], :notice => I18n.t("controller.question.update.notice")
    else
      render :edit
    end
  end

  def destroy
    @question = current_user.questions.find_by slug: params[:id]
    @question.destroy
    redirect_to :forum_root, :notice => I18n.t("controller.question.destroy.notice")
  end

  private

  def question_params
    params.require(:question).permit :answers_count, :body, :highlight, :title, :user, :user_id, :forum_id
  end

end
