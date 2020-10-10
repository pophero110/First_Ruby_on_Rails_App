class ArticlesController < ApplicationController
  before_action :set_articles, only: [:update, :edit, :show, :destroy]

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(articles_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render "new"
    end
  end

  def update
    if @article.update(articles_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render "edit"
    end
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def destroy
    @article.destroy
    redirect_to @article
  end

  private

  def set_articles
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :text)
  end
end
