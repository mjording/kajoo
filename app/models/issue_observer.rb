class IssueObserver < ActiveRecord::Observer
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  def after_create(issue)
    logger.warn("Doing after create for issue #{issue.title}")

    issue.add_free_vote_for 
  end
end

