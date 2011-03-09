class ReportObserver < ActiveRecord::Observer
  def logger
    RAILS_DEFAULT_LOGGER
  end
  def after_save(report)
    logger.info("SAVE: #{report.id}")
  end
end
