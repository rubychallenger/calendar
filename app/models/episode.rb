class Episode < ActiveRecord::Base
  belongs_to :title
  validates_uniqueness_of :title, scope: [:season, :number]
  before_create :match_day

  def match_day
    self.airdate ||= Date.new(2099,1,1)
    self.wday = self.airdate.strftime("%A")
  end
end
