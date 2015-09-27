module DeviseHelper
  def devise_resource
    Admin.new
  end

  def devise_resource_name
    :admin
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:admin]
  end

  def devise_error_messages!
      return "" if devise_resource.errors.empty?

      return devise_resource.errors
  end
end