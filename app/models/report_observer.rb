class ReportObserver < ActiveRecord::Observer
  def logger
    RAILS_DEFAULT_LOGGER
  end
  def before_save(report)
    logger.info("b4 SAVE: #{report.title}")
  end
end
