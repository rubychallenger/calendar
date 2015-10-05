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
      puts 'hahah'
      puts @title.errors[:name]
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
    require 'httparty'
    apikey = "40B65899C751376C"
    response = HTTParty.get("http://thetvdb.com/api/GetSeries.php?seriesname=#{@title.name.gsub(' ','%20')}").to_hash

    #puts response
    unless response.empty?
      resp = response["Data"]["Series"].is_a?(Hash) ? response["Data"]["Series"] : response["Data"]["Series"].select {|series| series["SeriesName"] == "#{@title.name}" }[0]
      
      if resp.is_a? NilClass
        resp = response["Data"]["Series"].delete_if {|series| series["FirstAired"].is_a? NilClass }.max_by do |series|
          DateTime.strptime((series["FirstAired"]),"%Y-%m-%d")
        end
      end

      @title.update_attribute( :Api_id, resp["seriesid"]) if @title.Api_id == nil
    end

    full_response = HTTParty.get("http://thetvdb.com/api/#{apikey}/series/#{@title.Api_id}/all/en.xml").to_hash["Data"]

    @title.update_attribute(:name, full_response["Series"]["SeriesName"].gsub(/[^a-zA-Z ]\s$/,''))
    @title.update_attribute(:picture, "http://thetvdb.com/banners/" + full_response["Series"]["fanart"])
    @title.update_attribute(:overview, full_response["Series"]["Overview"])
    
    series_response = full_response["Episode"].select {|ep| ep["Combined_season"].to_i > 0 }

    series_response.each_with_index do |ep,index|
      episode = Episode.create_with(airdate: DateTime.strptime( "#{ep["FirstAired"]||series_response[0]["FirstAired"]}" + " " + full_response["Series"]["Airs_Time"], '%Y-%m-%d %I:%M %p' )).find_or_create_by(name: ep["EpisodeName"]) 
      episode.update_attribute(:season, ep["Combined_season"].to_i)
      episode.update_attribute(:number, ep["Combined_episodenumber"].to_i)
      episode.title = @title
      episode.update_attribute(:airdate, DateTime.strptime( (ep["FirstAired"] || "2099-10-10") + " " + full_response["Series"]["Airs_Time"], '%Y-%m-%d %I:%M %p' ))
      
    end

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
