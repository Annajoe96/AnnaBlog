class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show,:edit ,:update, :destroy]

  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to root_path
    else
      flash.now[:alert] = @article.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @comment = @article.comments.new
    @author = @article.user
  end

  def edit
    if current_user.id != @article.user_id
      flash[:alert] = "You can't edit this article"
      redirect_to @article
    end
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
    if current_user.id == @article.user_id
      @article.destroy
      redirect_to root_path
    else
      flash[:alert] = "You can't delete this article"
      redirect_to @article
    end
  end




  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end




end
