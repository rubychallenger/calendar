module DeviseHelper
   def devise_error_messages!
      return "" if devise_resource.errors.empty?

      return devise_resource.errors
   end
end