#require 'google_charts_on_rails'

class PagesController < ApplicationController


  def index
    @issues = fetch_issues
  end

  #XXX TODO - sleep
  def dashboard
    @issues = fetch_issues
    @submitted_reports = Report.all.count
    @resolved_reports = Issue.where(:resolved => true).join(:reports).count('reports')
    @user_count = User.all.count
    
    chart = GoogleChart.bar_vertical_stacked_250x100(10,20,15,50,5,15,22,25,19,60)
    
    @submissions_chart_url = chart.to_url
    
    map = GoogleChart.map_635x313()
    
    @submissions_map_url = map.to_url
  end

  def about
  
  end
  
  def contact
  
  end

  def updates
    @versions = VestalVersions::Version.find(:all, :order => 'created_at desc').limit(50)
  end

end
