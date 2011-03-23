class ReportObserver < ActiveRecord::Observer
  
  def logger
    RAILS_DEFAULT_LOGGER
  end
  def before_create(report)
    if report.issue.nil?
      #issue = Issue.find_by_title( report.title )
      
      issue = Issue.tagged_with(report.description.summarize(:topics => true).last.split(',')).near([report.lat,report.lon],1).first
 
      puts "found issue #{issue.id}"  unless issue.nil? 
      issue ||= Issue.new({
            :description => report.description,
            :location => report.location,
            :lat => report.lat,
            :lon => report.lon,
            :creator => report.user
        })
      report.issue = issue
    end
  end
  
  def after_create(report)
    puts "Doing after create for report #{report.id}"
    issue = report.issue
    issue.discovered_list = report.generate_category_list.uniq unless issue.nil?
    issue.reports << report unless issue.nil? or issue.reports.index(report)
    issue.save!
  end
end
