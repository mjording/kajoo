#require 'google_charts_on_rails'

class PagesController < ApplicationController

  def index
    get_issues
  end

  def dashboard
     @nearissues = Issue.near(site_location, site_radius)
     @issues = @nearissues.page(params[:page]).per(10)
     @issue_markers = @issues.to_json
     @submitted_reports = Report.all.count
     @user_count = User.all.count
     chart = GoogleChart.bar_vertical_stacked_300x100(10,20,15,50,5,15,22,25,19,60)
     @submissions_chart_url = chart.to_url
  end
  def about
  
  end
  
  def contact
  
  end

  def updates
    @versions = VestalVersions::Version.find(:all, :order => 'created_at desc').limit(50)
  end
  
  def helpus
  
  end

  def help
    
  end

end
