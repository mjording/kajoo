class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  #def dashboard
  #  @user = current_user
  #end
  
  def show
    
    @user = User.find_by_twitter_username(params[:userid]) || User.find(params[:userid])
    @issues = @user.reports.map{|r|r.issue}
    @reports = @user.reports.page(params[:page]).per(5)
 #.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
  end
  
  # ajax method updated from client so that we can cache geolocation in cookie for sharing between client and server
  def location
    @lat = params[:lat]
    @lon = params[:lon]
    
    current_user.lat = cookies[:lat] = @lat
    current_user.lon = cookies[:lon] = @lon
    
    if current_user.save    
      respond_to do |format|
        format.html { 
          #render :text => "user location set to (#{@lat},#{@lon})"
        }
        format.js {
          # XXX TODO update user loc indicator on web app
          # and set in-page vars (user_location_updated, etc)
          #render :text => "user location set to (#{@lat},#{@lon})"        
        }
      end
    else
      respond_do do |format|
        format.html { 
          render :text => "error saving user location: #{current_user.errors.inspect}"
        }
        format.js { 
          render :text => "error saving user location: #{current_user.errors.inspect}"
        }
      end

    end
  end
end
