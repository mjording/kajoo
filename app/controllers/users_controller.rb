class UsersController < ApplicationController
  def dashboard
    @user = current_user
  end
  def show
    @user = User.find(params[:id])
    @issues = @user.reports.map{|r|r.issue}
  end
end
