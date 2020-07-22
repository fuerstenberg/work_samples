class ArticlesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]
  before_filter :set_article, only: [:show, :edit, :update, :destroy]
  after_filter :count_impression, only: :show

  has_scope :by_user,      only: [:index], as: :user_id
  # has_scope :order,        only: [:index], default: { published_at: :desc, updated_at: :desc }
  has_scope :current_user, only: [:index], type: :boolean do |controller, scope|
    if controller.current_user
      scope.by_user(controller.current_user.id)
    else
      scope
    end
  end

  def index
    @articles = apply_scopes(Article)
    @articles = @articles.active.where(:published_at.lt => Time.current).order(published_at: :desc, updated_at: :desc)
    if params[:query]
      @articles = @articles.search params[:query], page: params[:page]
    else
      @articles = @articles.page(params[:page]).per 30
    end
  end

  def show
  end

  def new
    authorize! :create, Article
    @article = current_user.articles.build
  end

  def create
    authorize! :create, Article
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article, :notice => I18n.t("controller.articles.create.notice")
    else
      render :new
    end
  end

  def edit
    authorize! :update, @article
  end

  def update
    authorize! :update, @article
    if @article.update_attributes(article_params)
      redirect_to @article, :notice => I18n.t("controller.articles.update.notice")
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @article
    if @article.destroy
      redirect_to :articles, :notice => I18n.t("controller.articles.destroy.notice")
    end
  end

  private

  def set_article
    @article = Article.find_by slug: params[:id]
  end

  def article_params
    params.require(:article).permit :active, :body, :group_id, :http, :news, :photo_uploaded_at, :source, :title, :user_id
  end

end
