class ReportObserver < ActiveRecord::Observer
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
  #def before_create(report)
  #  logger.warn("Doing after create for report #{report.title}")
  #end
  def before_create(report)
    puts "Doing after create for report #{report.title}"
    #begin 
    issue = Issue.create(:title => report.title, :description => report.description, :lat => report.lat, :lon => report.lon, :radius => report.radius)
    #  report.issue = issue
    #  issue.add_vote_for_user(report.user)
    #  issue.save!
    #rescue Exception => e
    #  puts "Error saving Issue for Report: '#{e.message}'"
    #end
  end
end
