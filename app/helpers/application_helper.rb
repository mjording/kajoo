module ApplicationHelper
  def site_name
    SITE['site_name']
  end
  
  def region_name
    SITE['region_name']
  end
  
  def summary_date(date)
    #March 8, 2011
    date.strftime('%M %d, %Y')
  end 
end
