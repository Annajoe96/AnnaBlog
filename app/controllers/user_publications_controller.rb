class UserPublicationsController < ApplicationController
  # before_action :set_user_publication
  before_action :find_publication, only: [:index,:create, :destroy, :new]

  # GET /user_publications
  def index
    @user_publications = UserPublication.all
  end

  # GET /user_publications/new
  def new
    @user_publication = @publication.user_publications.new
  end

  # POST /user_publications
  def create
    @user_publication = @publication.user_publications.new(user_publication_params)
    if @user_publication.save
      redirect_to new_publication_user_publication_path(@publication)
    else
      flash.now[:alert] = @user_publication.errors.full_messages.join(', ')
      render :new
    end
  end

  # DELETE /user_publications/1
  def destroy
    @user_publication.destroy
  end

  # private
    # Use callbacks to share common setup or constraints between actions.

  def find_publication
    @publication = Publication.find(params[:publication_id])
  end

  def user_publication_params
    params.require(:user_publication).permit(:email)
  end



end
