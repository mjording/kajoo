class ReportObserver < ActiveRecord::Observer
  def logger
    RAILS_DEFAULT_LOGGER
  end
  def after_save(report)
    similars = Report.find_similar(report)
    logger.info("b4 SAVE: #{report.title} is similar to #{similars.count}")
    
  end
end
