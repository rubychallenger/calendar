class Title < ActiveRecord::Base
	has_many :episodes, dependent: :destroy
	validates_presence_of :name
end
