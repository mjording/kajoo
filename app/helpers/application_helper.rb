module ApplicationHelper

  def site_name
    SITE['site_name']
  end
  
  def city_name
    SITE['city_name']
  end
  
  def state_name
    SITE['state_name']
  end
  
  def country_name
    SITE['country_name']
  end
  
  # XXX TODO - pull this from js when the plane lands :-)
  def user_lat
#    if(SITE['geolocate_enabled'])
    return SITE['default_user_lat']
  end
  
  def user_lon
    return SITE['default_user_lon']
  end
  
  def distance_units
    return SITE['units'].to_sym
  end
  
  def distance_units_name
    (SITE['units'] == 'mi') ? 'miles' : 'kms'
  end
  
  def available_achievements
    return Achievement::ACHIEVEMENTS
  end
  
  def summary_date(date)
    #March 8, 2011
    date.strftime('%B %d, %Y')
  end 
end
