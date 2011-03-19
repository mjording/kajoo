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
      issue = Issue.create(:title => report.title, :description => report.description, :lat => report.lat, :lon => report.lon, :radius => report.radius, :creator => report.user, :auto_categories_list => report.generate_categories_list )
      report.issue = issue
    else
      issue = report.issue
      issue.auto_categories_list = (report.issue.auto_categories_list + report.generate_category_list ).uniq.inspect
      puts "there was an existing issue for report #{report.title} called #{issue.title}"
    end
    
    issue.add_vote_for_user(report.user)    
  end
  def after_create(report)
    autocats = (report.title.summarize(:topics => true).last.split + report.description.summarize(:topics => true).last.split).uniq.inspect
  end
end
