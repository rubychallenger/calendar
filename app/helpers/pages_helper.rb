module PagesHelper
  def set_icon(ep)
    if cookies[:highlight].split(',').include?(ep.title.name) 
      "fi-minus highlight"
    else
      "fi-plus highlight"
    end
  end
end
