class Title < ActiveRecord::Base
  has_many :episodes, dependent: :destroy
  validates_presence_of :name

  def refresh_from_API(apikey, lookup_method = 1)
    response = HTTParty.get("http://thetvdb.com/api/GetSeries.php?seriesname=#{self.name.gsub(' ','%20')}").to_hash

    #puts response
    unless response.empty?
      resp = response["Data"]["Series"].is_a?(Hash) ? response["Data"]["Series"] : response["Data"]["Series"].select {|series| series["SeriesName"] == "#{self.name}" }[0]
      
      if resp.is_a? NilClass
        resp = response["Data"]["Series"].delete_if {|series| series["FirstAired"].is_a? NilClass }.max_by do |series|
          DateTime.strptime((series["FirstAired"]),"%Y-%m-%d")
        end
      end

      self.update_attribute( :Api_id, resp["seriesid"]) if self.Api_id == nil
    end

    full_response = HTTParty.get("http://thetvdb.com/api/#{apikey}/series/#{self.Api_id}/all/en.xml").to_hash["Data"]

    self.update_attribute(:name, full_response["Series"]["SeriesName"].gsub(/[^a-zA-Z\s]/,''))
    self.update_attribute(:picture, "http://thetvdb.com/banners/" + full_response["Series"]["fanart"])
    self.update_attribute(:overview, full_response["Series"]["Overview"])
    
    series_response = full_response["Episode"].select {|ep| ep["Combined_season"].to_i > 0 }

    series_response.each do |ep|
      episode = Episode.create_with(airdate: DateTime.strptime( "#{ep["FirstAired"]||series_response[0]["FirstAired"]}" + " " + full_response["Series"]["Airs_Time"], '%Y-%m-%d %I:%M %p' )).find_or_create_by(name: ep["EpisodeName"]) 
      episode.update_attributes({season: ep["Combined_season"].to_i,number: ep["Combined_episodenumber"].to_i,airdate: DateTime.strptime( (ep["FirstAired"] || "2099-10-10") + " " + full_response["Series"]["Airs_Time"], '%Y-%m-%d %I:%M %p' ), title_id: self.id})
    end
  end
end
