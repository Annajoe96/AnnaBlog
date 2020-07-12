class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show,:edit ,:update, :destroy]

  after_action :verify_authorized

  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page])
    authorize Article
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    authorize @article

    @article.user_id = current_user.id
    if @article.save
      ArticleMailer.with(article: @article).new_article_email.deliver_later
      flash[:success] = "Thank you for submitting an article. We'll get back to you soon"
      redirect_to root_path
    else
      flash.now[:alert] = @article.errors.full_messages.join(', ')
      render :new
    end

  end

  def show
    authorize @article

    @insight = ArticleInsightService.new(@article.body)
    @comment = @article.comments.new

    if user_signed_in?
      @like = @article.likes.where(user_id: current_user.id)&.first
    end

    @like ||= @article.likes.new

    @author = @article.user
  end

  def edit
    authorize @article
  end

  def update
    authorize @article

    if @article.update(article_params)
      redirect_to root_path
    else
      flash.now[:alert] =  @article.errors.full_messages.join(',')
      render :edit
    end
  end

  def destroy
    authorize @article

    @article.destroy
    redirect_to root_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end




end
