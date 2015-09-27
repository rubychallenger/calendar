class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!
  # GET /episodes
  def index
    @episodes = Episode.all
  end

  # GET /episodes/1
  def show
  end

  # GET /episodes/new
  def new
    @title = Title.find(params[:title_id])
    @episode = @title.episodes.new

    respond_to do |format|
      format.js {render 'form'}
    end
  end

  # GET /episodes/1/edit
  def edit
    respond_to do |format|
      format.js {render 'form'}
    end
  end

  # POST /episodes
  def create
    @title = Title.find(eval(params[:title_id])[:value])
    @episode = @title.episodes.new(episode_params)

    if @episode.save
      respond_to do |format|
        format.html {redirect_to :back, notice: 'Episode was successfully updated.'}
        format.js {render inline: "location.reload();" }
      end
    else
      render :new
    end
  end

  # PATCH/PUT /episodes/1
  def update
    if @episode.update(episode_params)
      respond_to do |format|
        format.html {redirect_to :back, notice: 'Episode was successfully updated.'}
        format.js {render inline: "location.reload();" }
      end
    else
      render :edit
    end
  end

  # DELETE /episodes/1
  def destroy
    @episode.destroy
    redirect_to episodes_url, notice: 'Episode was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def episode_params
      params.require(:episode).permit(:name, :number, :season, :airdate, :title_id)
    end
end
