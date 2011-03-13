class ApplicationController < ActionController::Base
  has_mobile_fu
  
  #helper_method :is_mobile_device?


  #def is_mobile_device?
  #  return true
  #end

  protect_from_forgery

  #rescue_from(Exception) do |e|
    ##TODO: Flash something?
    #flash[:alert] = e.message
    #logger.error "Error: '#{e.message}'"
    
    ##respond_to do |format|
      ##format.html { redirect_to :back }
      ##format.js { 
        ##render :update do |page| 
          ##page.redirect_to(:back)
        ##end
      ##}
    ##end
  #end
  
#   helper_method :current_user

  def render_404
    render :file => "#{Rails.root}/public/404.html", :status => :not_found
  end

  protected

    SHOW_LIMIT = 10
  
    #the issues list from the front page and several other pages 
    def fetch_issues  
      @order = ['latest', 'votes', 'resolved'].include?(params[:order]) ?  params[:order] : 'latest'
      if(@order == 'latest')
        @issues = Issue.near("#{SITE['city_name']}, #{SITE['state_code']}, US", 100).order('created_at desc').limit(SHOW_LIMIT)
      elsif(@order == 'votes')
        @issues = Issue.near("#{SITE['city_name']}, #{SITE['state_code']}, US", 100).order('vote_count desc').limit(SHOW_LIMIT)
      elsif(@order == 'resolved')
        @issues = Issue.near("#{SITE['city_name']}, #{SITE['state_code']}, US", 100).where(:resolved => true).order('resolved_at desc').limit(SHOW_LIMIT)
      end
      @issues ||= Issue.near("#{SITE['city_name']}, #{SITE['state_code']}, US", 100)
    end
  
    #ensure we redirect to authenticate even on AJAX requests
    def authenticate_user!
     begin
       unless current_user
        
        store_location!
        
        respond_to do |format|
          format.html { redirect_to(user_omniauth_authorize_path(:twitter)) }
          format.js { 
            render :update do |page| 
              page.redirect_to(user_omniauth_authorize_path(:twitter))
            end
          }
        end
       
       end
     
     rescue ActiveRecord::RecordNotFound
       session[:user_id] = nil
       redirect
     end
    end  
  
    #return our stored action URL from pre-auth
    def stored_location_for(resource)
      if current_user && (action_url = stored_location)
        flash[:notice] = "Successfully logged in"
        return action_url
      end
      super( resource ) 
    end
  
#    def sign_in_and_redirect(user, options)
#      session[:user_id] = user.id
#      redirect_to stored_location || after_sign_in_path
#    end
  
#    def sign_out_and_redirect(resource_or_scope)
#      super(resource_or_scope)
#      session[:user_id] = nil
#      redirect_to after_sign_out_path, :notice => "Signed out!"
#    end

  private

#     def current_user
#       @current_user ||= User.find(session[:user_id]) if session[:user_id]
#     end
  
    def redirect
      store_location!
      redirect_to new_session_path
    end
  
    def store_location!
      session[:return_to] = request.fullpath if request.get?
    end
  
    def stored_location
      session.delete("return_to")
    end
  
    def after_sign_in_path
      root_path
    end
  
    def after_sign_out_path
      root_path
    end
end
