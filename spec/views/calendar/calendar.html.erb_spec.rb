require 'rails_helper'	

describe 'calendar/calendar.html.erb' do
	it "redirects to root after home click" do
		visit '/'

		render.should contain("Home")
	end
end