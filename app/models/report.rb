class Report < ActiveRecord::Base  
  mount_uploader :report_image, ReportImageUploader
  belongs_to :user
  belongs_to :issue
  validates_presence_of :user, :description
  
  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  reverse_geocoded_by :lat, :lon  do |obj, geo|
    obj.city = geo.city
    obj.zipcode = geo.postal_code
    obj.country_name = geo.country
    obj.country_code = geo.country_code 
    obj.address = geo.address
    obj.lat = geo.latitude
    obj.lon = geo.longitude
  end

  def create_action
    :report_issue
  end
  
  def add_points_for_user(user,action)
    user.add_points_for_action(action)
    user.save!
  end

  def zipcode_cannot_be_outside_city
    errors.add(:zipcode, "connot be outside the city") if 
      !ZIPS.include? zipcode.to_i
  end 


  def generate_category_list
    (description.summarize(:topics => true).last.split(',')).uniq
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

