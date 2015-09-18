class Episode < ActiveRecord::Base
	belongs_to :title

	before_create :match_wday

	def match_wday
		self.wday = self.airdate.strftime("%A")
	end
end
