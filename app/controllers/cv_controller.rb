class CvController < ApplicationController
  
  def nil.image_url *args
    nil
  end

  def index
    @all = Book.all + Project.all
    @all.sort_by(&:created_at)
    @tr = Dir.glob("app/assets/images/mainpage/*.jpg")
  end
  
  def books
    @books = Book.all
  end

  def projects
    @projects = Project.all
  end
end
