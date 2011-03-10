class PagesController < ApplicationController

  def index
    @issues = fetch_issues
  end

  def dashboard
    
  end

  def about
  
  end
  
  def contact
  
  end

  def updates
    @versions = VestalVersions::Version.find(:all, :order => 'created_at desc').limit(50)
  end

end
