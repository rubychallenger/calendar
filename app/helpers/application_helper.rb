module ApplicationHelper
  def devise_resource
    Admin.new
  end

  def devise_resource_name
    :admin
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:admin]
  end
end
