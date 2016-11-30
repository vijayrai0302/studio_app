class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = @album.images.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = album.images.build
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = @album.images.build(image_params)

   if @image.save
      redirect_to album_path(@image.album.id), notice: "The image #{@image.name} has been uploaded."
    else
      render "new"
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    @image = @album.images.find(params[:id])
    @image.update(image_params)
    redirect_to album_path(@image.album.id)
  end

  # DELETE /images/1
  # DELETE /images/1.json

  def destroy
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])
    @image.destroy
    redirect_to album_path(@image.album.id), notice:  "The image #{@image.name} has been deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @image = Album.find(params[:album_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
params.require(:image).permit(:name, :avatar, :album_id)
    end
end
