class ReportObserver < ActiveRecord::Observer
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
  def after_save(report)
    logger.warn("Doing after-save for report #{report.inspect}")

    similar_issues = Issue.find_similar(report)
    
    logger.info("b4 SAVE: #{report.title} is similar to #{similar_issues.count}")
    
    if(similar_issues.size == 0)
      report.create_issue({
        :title => report.title,
        :description => report.description,
        :lat => report.lat,
        :lon => report.lon,
        :radius => report.radius,
      })
    end
  end
end
