class ReportObserver < ActiveRecord::Observer
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
  def before_create(report)
    logger.warn("Doing after create for report #{report.title}")
  end
  #def after_save(report)
    #begin 
      #issue = Issue.new :title => report.title, :description => report.description, :lat => report.lat, :lon => report.lon, :radius => report.radius
      #issue.add_vote_for_user(report.user)
    #rescue

  #end
end
