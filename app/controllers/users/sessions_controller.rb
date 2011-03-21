class Users::SessionsController < Devise::SessionsController                                     

  # Have to reimplement :recall => "failure"
  # for warden to redirect to some action that will return what I want
  def create   
    resource = warden.authenticate!(:scope => resource_name, :recall => "failure")
    # set_flash_message :notice, :signed_in 
    sign_in_and_redirect(resource_name, resource)      
  end     
  
  ## Example of JSON response
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope      = Devise::Mapping.find_scope!(resource_or_scope)     
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    #render :json => { :success => true, :redirect  => stored_location_for(scope) || after_sign_in_path_for(resource) } 
    redirect_to after_sign_in_path_for(resource)
  end
            
  ## JSON login failure message                                                            
  def failure
    render :json => {:success => false, :errors => {:reason => "Login failed. Try again"}} 
  end   
  
end  
