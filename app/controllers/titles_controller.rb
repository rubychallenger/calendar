class TitlesController < ApplicationController
  before_action :set_title, only: [:show, :edit, :update, :destroy, :refresh_API]
  before_action :authenticate_admin!, except: [:show_popup]
  # GET /titles
  def index
    @titles = Title.all
    @visitors = Visitor.all
  end

  # GET /titles/1
  def show
  end

  # GET /titles/new
  def new
    @title = Title.new

    respond_to do |format|
      format.js {render 'form'}
    end
  end

  # GET /titles/1/edit
  def edit

    respond_to do |format|
      format.js {render 'form'}
    end
  end

  # POST /titles
  def create
    @title = Title.new(title_params)

    if @title.save
      respond_to do |format|
        format.html {redirect_to :back, notice: 'Episode was successfully created.'}
        format.js {  render inline: "location.reload();" }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: 'error in create'}
        format.js { render json: @title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /titles/1
  def update
    if @title.update(title_params)
      respond_to do |format|
        format.html {redirect_to :back, notice: 'Episode was successfully updated.'}
        format.js {render inline: "location.reload();" }
      end
    else
      render :edit
    end
  end

  # DELETE /titles/1
  def destroy
    @title.destroy
    redirect_to titles_url, notice: 'Title was successfully destroyed.'
  end


  def refresh_API
    @title.refresh_from_API(Rails.application.secrets.TVDB_apikey)

    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end  
  end

  def show_popup
    @title = Title.find_by_name(params[:name].gsub('_',' '))

    respond_to do |format|
      format.js
    end
  end

  def set_cookies
    arr = []
    arr = cookies[:highlight].split(',') if cookies[:highlight]
    if arr.include?(params[:name])
      arr.delete(params[:name])
    else
      arr << params[:name]
    end
    cookies[:highlight] = (arr.class == Array) ? arr.join(',') : ''
    redirect_to '/calendar'
  end 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_title
      @title = Title.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def title_params
      params.require(:title).permit(:name, :picture, :Api_id)
    end
end
