class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def dashboard
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
    @issues = @user.reports.map{|r|r.issue}
  end
end
