class ReportObserver < ActiveRecord::Observer
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
  #def before_create(report)
  #  logger.warn("Doing after create for report #{report.title}")
  #end
  def before_create(report)
    if(report.issue.nil?)
      puts "Doing after create for report #{report.title}"
      #begin 
      issue = Issue.create(:title => report.title, :description => report.description, :lat => report.lat, :lon => report.lon, :radius => report.radius)
      report.issue = issue
    else
      issue = report.issue
      puts "there was an existing issue for report #{report.title} called #{issue.title}"
    end
    
    issue.add_vote_for_user(report.user)    
  end
end
