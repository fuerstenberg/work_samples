class Admin::ArticlesController < Admin::ApplicationController

  def index
    @articles = Kaminari.paginate_array(Article.order(created_at: :desc)).page(params[:page]).per(100)
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes(article_params)
      flash[:notice] = "Artikel wurde aktualisiert."
      redirect_to [:admin, :articles]
    else
      flash[:error] = "Artikel konnte nicht gespeichert werden."
      render :edit
    end
  end

  def destroy
    @article = Article.find params[:id]
    if @article.destroy
      flash[:notice] = "Artikel wurde entfernt."
    else
      flash[:error] = "Artikel konnte nicht entfernt werden."
    end
    redirect_to [:admin, :articles]
  end

  private

  def article_params
    params.require(:article).permit!
  end

end
