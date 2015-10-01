class VisitorsController < ApplicationController
  def destroy
    Visitor.find(params[:id]).destroy
    redirect_to titles_url
  end
end
