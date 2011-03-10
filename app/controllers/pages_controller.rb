class PagesController < ApplicationController

  def index
    @issues = fetch_issues
  end

  def dashboard
    
  end

end
