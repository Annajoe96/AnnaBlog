class PublicationsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  # GET /publications
  # GET /publications.json
  def index
    @publications = Publication.all
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)
    authorize @publication
    @user_publication = UserPublication.new
    if @publication.save
      @user_publication.user_id = current_user.id
      @user_publication.publication_id = @publication.id
      @user_publication.save
      redirect_to publication_path(@publication)
    else
      render :new
    end
  end

  def edit
    authorize @publication
  end


  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    authorize @publication
    if @publication.update(publication_params)
      redirect_to publication_path(@publication)
    else
      flash.now[:alert] =  @publication.errors.full_messages.join(',')
      render :edit
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: 'Publication was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:title, :description)
    end
end
