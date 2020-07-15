class PublicationsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /publications
  def index
    @publications = Publication.all
    authorize Publication
  end

  # GET /publications/1
  def show
    authorize @publication
  end

  # GET /publications/new
  def new
    @publication = Publication.new
    authorize @publication
  end



  # POST /publications
  def create
    @publication = Publication.new(publication_params)
    authorize @publication
    if @publication.save
      UserPublication.create(user_id: current_user.id, publication_id: @publication.id)
      redirect_to publication_path(@publication)
    else
      render :new
    end
  end

    # GET /publications/1/edit
  def edit
    authorize @publication
  end


  # PATCH/PUT /publications/1
  def update
    authorize @publication
    if @publication.update(publication_params)
      redirect_to publication_path(@publication)
    else
      render :edit
    end
  end

  # DELETE /publications/1
  def destroy
    authorize @publication

    @publication.destroy
    redirect_to publications_url
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
