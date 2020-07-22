class LinkedArticlesController < ApplicationController

  layout 'fullscreen_formular', only: [:new, :create, :edit, :update]

  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_before_action :verify_authenticity_token, only: [:show]

  before_action :set_linked_article
  after_filter :count_impression, only: :show

  def show
    authorize! :read, @linked_article
    render :show, layout: 'article_reader'
  end

  def new
    authorize! :create, LinkedArticle
    @linked_article = LinkedArticle.new
  end

  def create
    authorize! :create, LinkedArticle
    @linked_article = LinkedArticle.new(linked_article_params)
    if @linked_article.save
      redirect_to @linked_article, :notice => I18n.t("controller.linked_articles.create.notice")
    else
      render :new
    end
  end

  def edit
    authorize! :update, @linked_article
  end

  def update
    authorize! :update, @linked_article
    if @linked_article.update_attributes(linked_article_params)
      redirect_to @linked_article, :notice => I18n.t("controller.linked_articles.update.notice")
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @linked_article
    if @linked_article.destroy
      redirect_to :linked_articles, :notice => I18n.t("controller.linked_articles.destroy.notice")
    end
  end

  private

  def linked_article_params
    params.require(:linked_article).permit :active, :body, :group_id, :http, :news, :photo_uploaded_at, :source, :title, :user_id
  end

  def set_linked_article
    @linked_article = LinkedArticle.find_by slug: params[:id]
  end

end
