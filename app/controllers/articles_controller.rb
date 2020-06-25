class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      flash.now[:alert] = @article.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to root_path
    else
      flash.now[:alert] =  @article.errors.full_messages.join(',')
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  end


  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :author, :body)
  end


end
