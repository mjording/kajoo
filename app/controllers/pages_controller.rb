#require 'google_charts_on_rails'

class PagesController < ApplicationController


  def index
     #@issues = case params[:order] 
                #when 'votes' then Issue.page(params[:page]||'1').order('vote_count desc')
                #when 'resolved' then Issue.where(:resolved => true).page(params[:page]||'1').order('resolved_at desc')
                #when 'near' then Issue.near(site_location, site_radius).page(params[:page]||'1')
                #else Issue.near(site_location, site_radius).page(params[:page]||'1')
               #end


        @issues = Issue.near(site_location, site_radius).page(params[:page]).per(5)
        #all
        #@issues.instance_eval <<-EVAL
              #def current_page
                ##{params[:page] || 1}
              #end
              #def num_pages
                #count
              #end
              #def limit_value                                                                               
                #10
              #end
        #EVAL
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
     @issues = Issue.near(site_location, site_radius).page(params[:page]).per(5)
 
     @submitted_reports = Report.all.count
    @resolved_reports = Issue.where(:resolved => true).join(:reports).count('reports')
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
