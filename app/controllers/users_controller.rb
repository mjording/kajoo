class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  #def dashboard
  #  @user = current_user
  #end
  
  def show
    
    @user = User.find_by_twitter_username(params[:userid]) || User.find(params[:userid])
    @issues = @user.reports.map{|r|r.issue}
    @reports = @user.reports.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
  end
end
