class Report < ActiveRecord::Base  
  #versioned
  mount_uploader :report_image, ReportImageUploader
  belongs_to :user
  belongs_to :issue
  validates_presence_of :user, :title, :description
  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  #_with_city_and_state, :latitude  => :lat, :longitude => :lon
  
  reverse_geocoded_by :lat, :lon do |obj, geo|
  #, :address => :location 
    obj.city = geo.city
    obj.zipcode = geo.postal_code
    obj.country_name = geo.country
    obj.country_code = geo.country_code 
    obj.street_address = geo.address
    obj.lat = geo.latitude
    obj.lon = geo.longitude
  end
  
  def categories
    if tags
      tags.split.map{|tag|tag.strip.gsub(',','')}.flatten
    else
      []
    end
  end

  def generate_category_list
    (title.summarize(:topics => true).last.split(',') + description.summarize(:topics => true).last.split(',')).uniq
  end
end



# == Schema Information
#
# Table name: reports
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  title          :string(255)
#  description    :text
#  lat            :float
#  lon            :float
#  radius         :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  issue_id       :integer(4)
#  tags           :string(255)
#  address        :text
#  ip_address     :string(255)
#  location       :text
#  city           :string(255)
#  state          :string(255)
#  country_code   :string(255)
#  country_name   :string(255)
#  street_address :string(255)
#  zipcode        :string(255)
#

