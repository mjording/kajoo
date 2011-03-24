#require 'google_charts_on_rails'

class PagesController < ApplicationController

  def index
    get_issues
  end

  #XXX TODO - sleep
  def dashboard
   #@issues = case params[:order] 
                #when 'votes' then Issue.page(params[:page]||'1').order('vote_count desc')
                #when 'resolved' then Issue.where(:resolved => true).page(params[:page]||'1').order('resolved_at desc')
                #when 'near' then Issue.near(site_location, site_radius).page(params[:page]||'1')
                #else Issue.near(site_location, site_radius).page(params[:page]||'1')
               #end
     #@issues = Issue.near(site_location, site_radius, :select => "issues.*").page params[:page]
     @nearissues = Issue.near(site_location, site_radius)
     #@issue_pages = nearissues.count
     @issues = @nearissues.page(params[:page]).per(10)
     @submitted_reports = Report.all.count
    #@resolved_reports = Issue.where(:resolved => true).join(:reports).count('reports')
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
