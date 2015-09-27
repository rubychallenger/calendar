class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    respond_to do |format|
        format.json { render :json => {:success => true, :content => "HAHAHA"}, :status => :ok }
        format.html { respond_with resource, :location => after_sign_in_path_for(resource) } 
    end
  end

  def failure
    return render:json => {:success => false, :errors => ["Login failed."]}
  end

  protected

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end
end

