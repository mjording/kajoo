class PagesController < ApplicationController
  SHOW_LIMIT = 10

  def welcome
    fetch_issues
  end

  def dashboard
    
  end

end
