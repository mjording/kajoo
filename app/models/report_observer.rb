class ReportObserver < ActiveRecord::Observer
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
  def after_create(report)
    logger.warn("Doing after create for report #{report.title}")
    #similar_issues = Issue.find_similar(report)
    #logger.info("b4 SAVE: #{report.title} is similar to #{similar_issues.size}")
    #if(similar_issues.size == 0)
      #issue = Issue.create({
        #:title => report.title,
        #:description => report.description,
        #:lat => report.lat,
        #:lon => report.lon,
        #:radius => report.radius
      #})
      issue = Issue.create :title => report.title, :description => report.description, :lat => report.lat, :lon => report.lon, :radius => report.radius, :reports => [report] 
      
      #else
      #rep_issue = similar_issues.first
      #report.issue_id = issue.id
    #end
  end
end
